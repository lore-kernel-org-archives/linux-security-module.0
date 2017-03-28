From: nicolas.iooss_linux@m4x.org (Nicolas Iooss)
Date: Tue, 28 Mar 2017 23:10:35 +0200
Subject: [PATCH 1/1] apparmor: use SHASH_DESC_ON_STACK
In-Reply-To: <20170305143058.2554-1-nicolas.iooss_linux@m4x.org>
References: <20170305143058.2554-1-nicolas.iooss_linux@m4x.org>
Message-ID: <CAJfZ7=mRFD1xurKJ0u6ZDBgu-sXbut3s9xsu7BufFP7BETYp8g@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hello,
I sent the following patch three weeks ago and have not got any reply.
Could you please review it?

Thanks,
Nicolas

On Sun, Mar 5, 2017 at 3:30 PM, Nicolas Iooss
<nicolas.iooss_linux@m4x.org> wrote:
> When building the kernel with clang, the compiler fails to build
> security/apparmor/crypto.c with the following error:
>
>     security/apparmor/crypto.c:36:8: error: fields must have a constant
>     size: 'variable length array in structure' extension will never be
>     supported
>                     char ctx[crypto_shash_descsize(apparmor_tfm)];
>                          ^
>
> Since commit a0a77af14117 ("crypto: LLVMLinux: Add macro to remove use
> of VLAIS in crypto code"), include/crypto/hash.h defines
> SHASH_DESC_ON_STACK to work around this issue. Use it in aa_calc_hash()
> and aa_calc_profile_hash().
>
> Signed-off-by: Nicolas Iooss <nicolas.iooss_linux@m4x.org>
> ---
>  security/apparmor/crypto.c | 32 +++++++++++++-------------------
>  1 file changed, 13 insertions(+), 19 deletions(-)
>
> diff --git a/security/apparmor/crypto.c b/security/apparmor/crypto.c
> index de8dc78b6144..136f2a047836 100644
> --- a/security/apparmor/crypto.c
> +++ b/security/apparmor/crypto.c
> @@ -31,10 +31,7 @@ unsigned int aa_hash_size(void)
>
>  char *aa_calc_hash(void *data, size_t len)
>  {
> -       struct {
> -               struct shash_desc shash;
> -               char ctx[crypto_shash_descsize(apparmor_tfm)];
> -       } desc;
> +       SHASH_DESC_ON_STACK(desc, apparmor_tfm);
>         char *hash = NULL;
>         int error = -ENOMEM;
>
> @@ -45,16 +42,16 @@ char *aa_calc_hash(void *data, size_t len)
>         if (!hash)
>                 goto fail;
>
> -       desc.shash.tfm = apparmor_tfm;
> -       desc.shash.flags = 0;
> +       desc->tfm = apparmor_tfm;
> +       desc->flags = 0;
>
> -       error = crypto_shash_init(&desc.shash);
> +       error = crypto_shash_init(desc);
>         if (error)
>                 goto fail;
> -       error = crypto_shash_update(&desc.shash, (u8 *) data, len);
> +       error = crypto_shash_update(desc, (u8 *) data, len);
>         if (error)
>                 goto fail;
> -       error = crypto_shash_final(&desc.shash, hash);
> +       error = crypto_shash_final(desc, hash);
>         if (error)
>                 goto fail;
>
> @@ -69,10 +66,7 @@ char *aa_calc_hash(void *data, size_t len)
>  int aa_calc_profile_hash(struct aa_profile *profile, u32 version, void *start,
>                          size_t len)
>  {
> -       struct {
> -               struct shash_desc shash;
> -               char ctx[crypto_shash_descsize(apparmor_tfm)];
> -       } desc;
> +       SHASH_DESC_ON_STACK(desc, apparmor_tfm);
>         int error = -ENOMEM;
>         __le32 le32_version = cpu_to_le32(version);
>
> @@ -86,19 +80,19 @@ int aa_calc_profile_hash(struct aa_profile *profile, u32 version, void *start,
>         if (!profile->hash)
>                 goto fail;
>
> -       desc.shash.tfm = apparmor_tfm;
> -       desc.shash.flags = 0;
> +       desc->tfm = apparmor_tfm;
> +       desc->flags = 0;
>
> -       error = crypto_shash_init(&desc.shash);
> +       error = crypto_shash_init(desc);
>         if (error)
>                 goto fail;
> -       error = crypto_shash_update(&desc.shash, (u8 *) &le32_version, 4);
> +       error = crypto_shash_update(desc, (u8 *) &le32_version, 4);
>         if (error)
>                 goto fail;
> -       error = crypto_shash_update(&desc.shash, (u8 *) start, len);
> +       error = crypto_shash_update(desc, (u8 *) start, len);
>         if (error)
>                 goto fail;
> -       error = crypto_shash_final(&desc.shash, profile->hash);
> +       error = crypto_shash_final(desc, profile->hash);
>         if (error)
>                 goto fail;
>
> --
> 2.11.1
>
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
