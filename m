From: grundler@chromium.org (Grant Grundler)
Date: Wed, 22 Mar 2017 17:30:15 -0700
Subject: [PATCH] selinux: Remove unnecessary check of array base in
	selinux_set_mapping()
In-Reply-To: <20170316222652.125702-1-mka@chromium.org>
References: <20170316222652.125702-1-mka@chromium.org>
Message-ID: <CANEJEGuYDz2GVePRtP+uvs=Kce5--_1ZEGkVmSo0-tT7wpHy+A@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

[resending as plain text only - sorry]

Ping? Any feedback on this patch?

LGTM.

cheers,
grant

On Thu, Mar 16, 2017 at 3:26 PM, Matthias Kaehlcke <mka@chromium.org> wrote:
> 'perms' will never be NULL since it isn't a plain pointer but an array
> of u32 values.
>
> This fixes the following warning when building with clang:
>
> security/selinux/ss/services.c:158:16: error: address of array
> 'p_in->perms' will always evaluate to 'true'
> [-Werror,-Wpointer-bool-conversion]
>                 while (p_in->perms && p_in->perms[k]) {
>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  security/selinux/ss/services.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index 082b20c78363..2f20b5f974f4 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -155,7 +155,7 @@ static int selinux_set_mapping(struct policydb *pol,
>                 }
>
>                 k = 0;
> -               while (p_in->perms && p_in->perms[k]) {
> +               while (p_in->perms[k]) {
>                         /* An empty permission string skips ahead */
>                         if (!*p_in->perms[k]) {
>                                 k++;
> --
> 2.12.0.367.g23dc2f6d3c-goog
>
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
