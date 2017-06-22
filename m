From: casey@schaufler-ca.com (Casey Schaufler)
Date: Thu, 22 Jun 2017 12:59:14 -0700
Subject: [PATCH 0/3] Enable namespaced file capabilities
In-Reply-To: <1498157989-11814-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1498157989-11814-1-git-send-email-stefanb@linux.vnet.ibm.com>
Message-ID: <70a09f1b-e82c-a25c-9325-d5d757b1b695@schaufler-ca.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 6/22/2017 11:59 AM, Stefan Berger wrote:
> This series of patches primary goal is to enable file capabilities
> in user namespaces without affecting the file capabilities that are
> effective on the host. This is to prevent that any unprivileged user
> on the host maps his own uid to root in a private namespace, writes
> the xattr, and executes the file with privilege on the host.
>
> We achieve this goal by writing extended attributes with a different
> name when a user namespace is used. If for example the root user
> in a user namespace writes the security.capability xattr, the name
> of the xattr that is actually written is encoded as
> security.capability at uid=1000 for root mapped to uid 1000 on the host.

You need to identify the instance of the user namespace for
this to work right on a system with multiple user namespaces.
If I have a shared filesystem mounted in two different user
namespaces a change by one will affect the other.

... unless I'm missing something obvious about namespace behavior.

> When listing the xattrs on the host, the existing security.capability
> as well as the security.capability at uid=1000 will be shown. Inside the
> namespace only 'security.capability', with the value of
> security.capability at uid=1000, is visible.
>
> To maintain compatibility with existing behavior, the value of
> security.capability of the host is shown inside the user namespace
> once the security.capability of the user namespace has been removed
> (which really removes security.capability at uid=1000). Writing to
> an extended attribute inside a user namespace effectively hides the
> extended attribute of the host.
>
> The general framework that is established with these patches can
> be applied to other extended attributes as well, such as security.ima
> or the 'trusted.' prefix . Another extended attribute that needed to
> be enabled here is 'security.selinux,' since otherwise this extended
> attribute would not be shown anymore inside a user namespace.
>
> Regards,
>    Stefan & Serge
>
>
> Stefan Berger (3):
>   xattr: Enable security.capability in user namespaces
>   Enable capabilities of files from shared filesystem
>   Enable security.selinux in user namespaces
>
>  fs/xattr.c               | 472 ++++++++++++++++++++++++++++++++++++++++++++++-
>  security/commoncap.c     |  36 +++-
>  security/selinux/hooks.c |   9 +-
>  3 files changed, 501 insertions(+), 16 deletions(-)
>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
