From: keescook@chromium.org (Kees Cook)
Date: Thu, 20 Sep 2018 10:13:17 -0700
Subject: [PATCH v3 07/16] TOMOYO: Abstract use of cred security blob
In-Reply-To: <ea146829-594a-64a5-6e60-427d39aff4bc@schaufler-ca.com>
References: <748c61cb-b6fa-c36d-a7b3-2315ff6292af@schaufler-ca.com>
	<ea146829-594a-64a5-6e60-427d39aff4bc@schaufler-ca.com>
Message-ID: <CAGXu5jJ0xB+Zh7oUAzk9kDMaFTOcNXFzOxL6mwqsw8KaQ0Ks-g@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, Sep 19, 2018 at 5:20 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> @@ -539,13 +557,16 @@ DEFINE_SRCU(tomoyo_ss);
>  static int __init tomoyo_init(void)
>  {
>         struct cred *cred = (struct cred *) current_cred();
> +       struct tomoyo_domain_info **blob;
>
>         if (!security_module_enable("tomoyo"))
>                 return 0;
> +
>         /* register ourselves with the security framework */
>         security_add_hooks(tomoyo_hooks, ARRAY_SIZE(tomoyo_hooks), "tomoyo");
>         printk(KERN_INFO "TOMOYO Linux initialized\n");
> -       cred->security = &tomoyo_kernel_domain;
> +       blob = tomoyo_cred(cred);
> +       *blob = &tomoyo_kernel_domain;
>         tomoyo_mm_init();
>         return 0;
>  }

This is missing "tomoyo_enabled = true;" which is included in the next
patch but should be here.

-Kees

-- 
Kees Cook
Pixel Security
