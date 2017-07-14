From: ebiederm@xmission.com (Eric W. Biederman)
Date: Fri, 14 Jul 2017 18:41:39 -0500
Subject: [PATCH v2] xattr: Enable security.capability in user namespaces
In-Reply-To: <1499785511-17192-2-git-send-email-stefanb@linux.vnet.ibm.com>
	(Stefan Berger's message of "Tue, 11 Jul 2017 11:05:11 -0400")
References: <1499785511-17192-1-git-send-email-stefanb@linux.vnet.ibm.com>
	<1499785511-17192-2-git-send-email-stefanb@linux.vnet.ibm.com>
Message-ID: <87d192si18.fsf@xmission.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Stefan Berger <"Stefan Bergerstefanb"@linux.vnet.ibm.com> writes:

> From: Stefan Berger <stefanb@linux.vnet.ibm.com>
>
> This patch enables security.capability in user namespaces but also
> takes a more general approach to enabling extended attributes in user
> namespaces.
>
> The following rules describe the approach using security.foo as a
> 'user namespace enabled' extended attribute:
>
> Reading of extended attributes:
>
> 1a) Reading security.foo from a user namespace will read
>     security.foo at uid=<uid> of the parent user namespace instead with uid
>     being the mapping of root in that parent user namespace. An
>     exception is if root is mapped to uid 0 on the host, and in this case
>     we will read security.foo directly.
>     --> reading security.foo will read security.foo at uid=1000 for uid
>         mapping of root to 1000.
>
> 1b) If security.foo at uid=<uid> is not available, the security.foo of the
>     parent namespace is tried to be read. This procedure is repeated up to
>     the init user namespace. This step only applies for reading of extended
>     attributes and provides the same behavior as older system where the
>     host's extended attributes applied to user namespaces.
>
> 2) All security.foo at uid=<uid> with valid uid mapping in the user namespace
>    can be read. The uid within the user namespace will be mapped to the
>    corresponding uid on the host and that uid will be used in the name of
>    the extended attribute.
>    -> reading security.foo at uid=1 will read security.foo at uid=1001 for uid
>       mapping of root to 1000, size of at least 2.
>
>    All security.foo at uid=<uid> can be read (by root) on the host with values
>    of <uid> also being subject to checking for valid mappings.
>
> 3) No other security.foo* can be read.
>
> The same rules for reading apply to writing and removing of user
> namespace enabled extended attributes.
>
> When listing extended attributes of a file, only those are presented
> to the user namespace that have a valid mapping. Besides that, names
> of the extended attributes are adjusted to represent the mapping.
> This means that if root is mapped to uid 1000 on the host, the
> security.foo at uid=1000 will be listed as security.foo in the user
> namespace, security.foo at uid=1001 becomes security.foo at uid=1 and so on.
>
> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
> Signed-off-by: Serge Hallyn <serge@hallyn.com>
> Reviewed-by: Serge Hallyn <serge@hallyn.com>
> ---
>  fs/xattr.c               | 509 +++++++++++++++++++++++++++++++++++++++++++++--
>  security/commoncap.c     |  36 +++-
>  security/selinux/hooks.c |   9 +-
>  3 files changed, 523 insertions(+), 31 deletions(-)

I am just going to quickly and publicly point out that as designed this
patch breaks evm inode metadata signing.  As evm_config_xattrnames is not
updated.

While not completely insurmountable that seems like a strong limitation of
this design.

Eric
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
