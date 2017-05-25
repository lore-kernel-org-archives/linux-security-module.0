From: john.johansen@canonical.com (John Johansen)
Date: Thu, 25 May 2017 08:32:17 -0700
Subject: [Patch v2 0/8] securityfs: add the ability to support symlinks
Message-ID: <20170525153225.19070-1-john.johansen@canonical.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

v2 - adjust for Kees's feedback
- use kvzlloc() instead of memset
- split [PATCH 3/3] apparmor: virtualize the policy/ directory
  into 6 patches

Currently securityfs does not support the creation/use of symlinks.

AppArmor would like to be able to use symlinks to map some policy
relationships between profiles and the data set it was loaded from
(patch 2), and to create a specialized magic policy namespace
dir that maps the policy/ directory to the policy namespace that a
task is confined by.

The following patchset adds symlink support to securityfs and then
updates apparmor to leverage them.

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
