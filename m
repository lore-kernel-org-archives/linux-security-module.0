From: casey@schaufler-ca.com (Casey Schaufler)
Date: Mon, 26 Mar 2018 07:56:06 -0700
Subject: [PULL] Smack: Changes for 4.17
Message-ID: <54904a33-26b5-7fbb-a307-35806ee92cf1@schaufler-ca.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Please pull for 4.17. One small change for Automotive Grade Linux.

The following changes since commit a02633e9b13dcb9b1a656b08f81bc8ba2d4d2294:

  Merge tag 'v4.16-rc2' into next-general (2018-02-21 08:21:41 -0800)

are available in the Git repository at:

  git://github.com/cschaufler/next-smack smack-for-4.17

for you to fetch changes up to 58c442f34c77ad80941e3da85cc0738e8e21d4f3:

  Smack: Handle CGROUP2 in the same way that CGROUP (2018-02-28 09:27:12 -0800)

----------------------------------------------------------------
Jos? Bollo (1):
      Smack: Handle CGROUP2 in the same way that CGROUP

 security/smack/smack_lsm.c | 2 ++
 1 file changed, 2 insertions(+)

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
