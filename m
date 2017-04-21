From: fw@strlen.de (Florian Westphal)
Date: Fri, 21 Apr 2017 11:49:07 +0200
Subject: [PATCH security-next 0/2]: switch selinux and smack to pernet ops
Message-ID: <20170421094909.28961-1-fw@strlen.de>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Back in the day we only had global netfilter hooks.

Nowadays netfilter hooks are per net namespace, but we still provide the old
'nf_register_hook' api, which will place the hooks in all current and future
net namespaces.

smack and selinux are among the last users of the old api, this
switches both over to pernet_ops.

This would also allow to only enable hooks in a netns when
they are needed in that namespace, but this isn't done here.

The old api makes it necessary to keep rather ugly code in
the netfilter core (e.g. iterating net namespaces under rtnl mutex...)
and it has a race w. rmmod. We'd like to remove it.

If you prefer this gets merged via nf-next tree please ack and I'll
resubmit (with acks) to netfilter-devel@ list.

 selinux/hooks.c         |   24 ++++++++++++++++++++----
 smack/smack_netfilter.c |   26 ++++++++++++++++++--------
 2 files changed, 38 insertions(+), 12 deletions(-)

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
