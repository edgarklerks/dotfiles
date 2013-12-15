# dotlog.py - display revision graph using graphviz DOT

import sys
import time
import os.path

from mercurial.cmdutil import revrange, show_changeset
from mercurial.i18n import _
from mercurial.node import nullid, nullrev, short
from mercurial.util import Abort, shortuser
from mercurial import revset

import pygraphviz

def get_limit(limit_opt):
    if not limit_opt:
        return sys.maxint
    try:
        limit = int(limit_opt)
    except ValueError:
        raise Abort(_("limit must be a positive integer"))
    if limit <= 0:
        raise Abort(_("limit must be positive"))
    return limit

def get_revs(repo, opts):
    revs = range(len(repo))
    if len(opts["rev_set"]):
        print "revision set ", opts["rev_set"]
        matcher = revset.match(opts["rev_set"])
        return set(matcher(repo, revs))
    else:
        return set(revs)

# The best colour assignment to make is this: of all the most popular
# remaining branches, and of all the least popular colours, 
# look at each branches most preferred colours trying to find a good pair,
# then their next most preferred, and so on.
# Use a simple hashing function based on the branch name to decide
# what colours they prefer in what order.
def best_pair(branch_pop, color_pop):
    colors = sorted(color_pop.keys())
    thresh = max(branch_pop.itervalues())
    ok_branches = set([b for b, p in branch_pop.iteritems() if p >= thresh])
    thresh = min(color_pop.itervalues())
    ok_colors = set([c for c, p in color_pop.iteritems() if p <= thresh])
    prefix = ":"
    while True:
        for b in ok_branches:
            c = colors[(prefix + b).__hash__() % len(colors)]
            if c in ok_colors:
                return b, c
        prefix = str(len(prefix)) + prefix

# Assign colours to branches - use branch popularity as a guide
# so that the more popular branches get their "preferred" colours
# and so that it's only the less popular ones which share colours.
def get_colors(numcolors, branch_pop):
    colors = {}
    color_pop = dict([(i, 0) for i in range(1, numcolors +1)])
    while branch_pop:
        branch, color = best_pair(branch_pop, color_pop)
        colors[branch] = color
        # Per-node cost 1, per-branch cost 2
        color_pop[color] += branch_pop[branch] + 2
        del branch_pop[branch]
    return colors
    
def find_ancestors(parents, ungrouped, a):
    res = set()
    while True:
        print a
        if a not in ungrouped:
            break
        res.add(a)
        ungrouped.remove(a)
        if len(parents[a]) == 1:
            a = list(parents[a])[0]
        else:
            for p in parents[a]:
                res |= find_ancestors(parents, ungrouped, p)
            break
    return res

def dotlog(ui, repo, **opts):
    """produce a dot file
    """

    anchor = opts["anchor"]
    if anchor is None or anchor == "":
        anchor = []
    else:
        anchor = [repo[a].rev() for a in anchor.split(",")]

    revisions = get_revs(repo, opts)
    parents = dict([(r,set()) for r in revisions])
    children = dict([(r,set()) for r in revisions])
    branch = {}
    for rev in revisions:
        for p in repo.changelog.parentrevs(rev):
            if p in revisions:
                parents[rev].add(p)
                children[p].add(rev)
        ctx = repo.changectx(rev)
        branch[rev] = ctx.branch()
    if opts['elide_simple']:
        multiparent = set([r for r in revisions 
            if len(parents[r]) != 1])
        multichild = set([r for r in revisions 
            if len(children[r]) != 1])
        todisplay = set([r for r in revisions
            if r in multiparent or r in multichild
                or len(parents[r] & multichild)
                or len(children[r] & multiparent)
                or len(set([branch[v] for v in (set([r])|parents[r]|children[r])]))>1])
    else:
        todisplay = revisions

    numcolors = opts.get('numcolors', 12)
    branch_popularity = {}
    for rev in todisplay:
        b = branch[rev]
        branch_popularity[b] = 1 + branch_popularity.get(b, 0)
    branchcolors = get_colors(numcolors, branch_popularity)
    g = pygraphviz.AGraph(ui.config("dotlog", "template",
        os.path.join(os.path.dirname(__file__), "template.dot")))
    ungrouped = revisions
    for i, a in enumerate(anchor):
        asg = g.subgraph(name="cluster-Ancestors-{0}".format(i))
        for r in find_ancestors(parents, ungrouped, a) & todisplay:
            asg.add_node(r)
    for r in ungrouped & todisplay:
        g.add_node(r)
    for rev in todisplay:
        ctx = repo.changectx(rev)
        day = time.strftime("%Y-%m-%d", time.localtime(ctx.date()[0]))
        color = branchcolors[branch[rev]]
        g.get_node(rev).attr.update(dict(
            color = str(color),
            label = "%s\\n%s %s\\n%s:%s" % (
                branch[rev], shortuser(ctx.user()), day, rev, short(ctx.node()))))
        if len(children[rev]) == 0:
            if ctx.extra().get('close'):
                g.get_node(rev).attr['shape'] = "octagon"
            else:
                g.get_node(rev).attr['shape'] = "house"
        for p in parents[rev]:
            if p in todisplay:
                if branch[p] == branch[rev]:
                    if branch[rev] == "default":
                        weight = 20
                    else:
                        weight = 5
                    penwidth = 2
                else:
                    weight = 1
                    penwidth = 0.5
                g.add_edge(p, rev)
                g.get_edge(p, rev).attr.update(dict(
                    weight=str(weight), penwidth=str(penwidth)))
            else:
                elided = 0
                while p not in todisplay:
                    p = parents[p].copy().pop()
                    elided += 1
                g.add_edge(p, rev)
                g.get_edge(p, rev).attr.update(dict(
                    weight="2", penwidth="2", labeldistance = "15",
                    color = "gray", label = "%d elided" % elided))
    g.write(opts['output'])

cmdtable = {
    "dotlog":
        (dotlog,
         [('s', 'rev-set', '', _('Show only the specified revision set')),
          ('a', 'anchor', '', _('Colour ancestors of the anchor differently')),
          ('e', 'elide-simple', None, _('Elide simple revisions')),
          ('o', 'output', '', _('Output file to write'))],
         _('hg dotlog [OPTION]...')),
}
