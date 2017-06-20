From: casey@schaufler-ca.com (Casey Schaufler)
Date: Tue, 20 Jun 2017 16:51:46 -0700
Subject: [PULL] Smack changes for 4.13
Message-ID: <a34aa1ab-8640-ceff-fa3c-2e5695f3dba0@schaufler-ca.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Three changes for Smack for 4.13

The following changes since commit d68c51e0b377838dd31b37707813bb62089f399c:

  Sync to mainline for security submaintainers to work against (2017-05-22 16:32:40 +1000)

are available in the git repository at:

  git://github.com/cschaufler/smack-next smack-for-4.13

for you to fetch changes up to f28e783ff668cf5757182f6b00d488be37226bff:

  Smack: Use cap_capable in privilege check (2017-06-01 09:27:21 -0700)

----------------------------------------------------------------
Casey Schaufler (2):
      Smack: Safer check for a socket in file_receive
      Smack: Use cap_capable in privilege check

Florian Westphal (1):
      smack: use pernet operations for hook registration

 security/smack/smack.h           |  2 +-
 security/smack/smack_access.c    | 19 +++++++++++--------
 security/smack/smack_lsm.c       |  2 +-
 security/smack/smack_netfilter.c | 26 ++++++++++++++++++--------
 4 files changed, 31 insertions(+), 18 deletions(-)

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
