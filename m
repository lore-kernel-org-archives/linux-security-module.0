From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Fri, 6 Apr 2018 16:07:02 -0700
Subject: [GIT PULL] SELinux patches for v4.17
In-Reply-To: <CAHC9VhQExmdXutVEhysGzf95CDzO_0sXFWQqndeeuChQ=0xbmA@mail.gmail.com>
References: <CAHC9VhQExmdXutVEhysGzf95CDzO_0sXFWQqndeeuChQ=0xbmA@mail.gmail.com>
Message-ID: <CA+55aFzzxfAL+Khed9nc-RzB2P3FxrCgr6Whmh_bYondTQvO6A@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, Apr 3, 2018 at 6:37 PM, Paul Moore <paul@paul-moore.com> wrote:
>
> Everything passes the selinux-testsuite, but there are a few known
> merge conflicts.  The first is with the netdev tree and is in
> net/sctp/socket.c.  Unfortunately it is a bit ugly, thankfully Stephen
> Rothwell has already done the heavy lifting in resolving the merge for
> you, and the SCTP folks have given his merge patch a thumbs-up.

I ended up re-doing the merge, and it looks like some more sctp
changes happened after Stephen's merge anyway, so mine didn't end up
quite like his.

Adding Xin Long to see if he can verify it again, but it all *looks* sane.

While looking at it, it struck me that the new security hooks don't
seem to hook into __sctp_connect(), which also does that

                        scope = sctp_scope(&to);
                        asoc = sctp_association_new(ep, sk, scope, GFP_KERNEL);

thing. Is that intentional? The sendmsg case does that
security_sctp_bind_connect, the actual __sctp_connect() does not.

This is not because I screwed up the merge - it's that way in the
SELinux tree too. And I obviously _left_ it that way, but while doing
the merge and trying to understand what was going on, this struck me.

I'm probably missing something really obvious why the connect case
doesn't want to do it thgere.

NOTE! I do see it being done in __sctp_setsockopt_connectx(). But
__sctp_connect() has another caller (in sctp_connect()) which doesn't
have that security_sctp_bind_connect() call.

So please check my resolution, but also somebody should tell me
"Linus, you're a cretin, sctp_connect() doesn't want that
security_sctp_bind_connect() at all because it was already done by
XYZ"

                 Linus
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
