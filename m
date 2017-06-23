From: amir73il@gmail.com (Amir Goldstein)
Date: Fri, 23 Jun 2017 10:01:46 +0300
Subject: [PATCH 0/3] Enable namespaced file capabilities
In-Reply-To: <1498157989-11814-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1498157989-11814-1-git-send-email-stefanb@linux.vnet.ibm.com>
Message-ID: <CAOQ4uxj=_Riih1K+QOYasZU8vZKCSrsg393f=17mJ2O-909e=Q@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, Jun 22, 2017 at 9:59 PM, Stefan Berger
<stefanb@linux.vnet.ibm.com> wrote:
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
> When listing the xattrs on the host, the existing security.capability
> as well as the security.capability at uid=1000 will be shown. Inside the
> namespace only 'security.capability', with the value of
> security.capability at uid=1000, is visible.
>

Am I the only one who thinks that suffix is perhaps not the best grammar
to use for this namespace?
xattrs are clearly namespaced by prefix, so it seems right to me to keep
it that way - define a new special xattr namespace "ns" and only if that
prefix exists, the @uid suffix will be parsed.
This could be either  ns.security.capability at uid=1000 or
ns at uid=1000.security.capability. The latter seems more correct to me,
because then we will be able to namespace any xattr without having to
protect from "unprivileged xattr injection", i.e.:
setfattr -n "user.whatever.foo at uid=0"

Amir.
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
