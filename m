From: john.johansen@canonical.com (John Johansen)
Date: Wed, 10 May 2017 19:46:22 -0700
Subject: [RFC][Patch 0/3] securityfs: add the ability to support symlinks
Message-ID: <20170511024625.13887-1-john.johansen@canonical.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Currently securityfs does not support the creation/use of symlinks.

AppArmor would like to be able to use symlinks to map some policy
relationships between profiles and the data set it was loaded from
(patch 2), and to create a specialized magic policy tree that maps
visible policy to the policy namespace that a task is confined by.

The following patchset adds symlink support to securityfs and then
updates apparmor to leverage them.

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
