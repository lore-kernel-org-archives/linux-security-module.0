From: paul@paul-moore.com (Paul Moore)
Date: Mon, 12 Jun 2017 11:40:22 -0400
Subject: [GIT PULL] SELinux fixes for v4.12 (#1)
Message-ID: <CAHC9VhSzDC8ezTGHzOdM_L=nGRqNaUzNjtV--sYAajJ5dr3MQw@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi James,

One small double-free fix for SELinux that I think should go upstream
for v4.12.  The patch passes the selinux-testsuite and applies cleanly
to your linux-security/next branch; please merge and pass this along
to Linus.

Thanks,
-Paul

---
The following changes since commit cae303df3f379f04ce7efadb2e30de460918b302:

 selinux: Fix an uninitialized variable bug (2017-03-31 15:16:18 -0400)

are available in the git repository at:

 git://git.infradead.org/users/pcmoore/selinux stable-4.12

for you to fetch changes up to 2118b6a4b68b30f6e2bba5ac586e80ed2cc5e462:

 selinux: fix double free in selinux_parse_opts_str() (2017-06-07 16:48:19 -040
0)

----------------------------------------------------------------
Paul Moore (1):
     selinux: fix double free in selinux_parse_opts_str()

security/selinux/hooks.c | 5 ++---
1 file changed, 2 insertions(+), 3 deletions(-)

-- 
paul moore
www.paul-moore.com
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
