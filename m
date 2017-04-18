From: keescook@chromium.org (Kees Cook)
Date: Tue, 18 Apr 2017 14:48:00 -0700
Subject: [PATCH net-next v6 01/11] bpf: Add eBPF program subtype and
	is_valid_subtype() verifier
In-Reply-To: <20170328234650.19695-2-mic@digikod.net>
References: <20170328234650.19695-1-mic@digikod.net>
	<20170328234650.19695-2-mic@digikod.net>
Message-ID: <CAGXu5j+vRGFvJZmjtAcT8Hi8B+Wz0e1b6VKYZHfQP_=DXzC4CQ@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, Mar 28, 2017 at 4:46 PM, Micka?l Sala?n <mic@digikod.net> wrote:
> The goal of the program subtype is to be able to have different static
> fine-grained verifications for a unique program type.
>
> The struct bpf_verifier_ops gets a new optional function:
> is_valid_subtype(). This new verifier is called at the beginning of the
> eBPF program verification to check if the (optional) program subtype is
> valid.
>
> For now, only Landlock eBPF programs are using a program subtype (see
> next commit) but this could be used by other program types in the future.
>
> Changes since v5:
> * use a prog_subtype pointer and make it future-proof
> * add subtype test
> * constify bpf_load_program()'s subtype argument
> * cleanup subtype initialization
> * rebase
>
> Changes since v4:
> * replace the "status" field with "version" (more generic)
> * replace the "access" field with "ability" (less confusing)
>
> Changes since v3:
> * remove the "origin" field
> * add an "option" field
> * cleanup comments
>
> Signed-off-by: Micka?l Sala?n <mic@digikod.net>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: David S. Miller <davem@davemloft.net>
> Link: https://lkml.kernel.org/r/20160827205559.GA43880 at ast-mbp.thefacebook.com
> ---
> [...]
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index c35ebfe6d84d..3d07b10ade5e 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -843,6 +879,26 @@ static int bpf_prog_load(union bpf_attr *attr)
>         if (err < 0)
>                 goto free_prog;
>
> +       /* copy eBPF program subtype from user space */
> +       if (attr->prog_subtype) {
> +               __u32 size;
> +
> +               size = check_user_buf((void __user *)attr->prog_subtype,
> +                                     attr->prog_subtype_size,
> +                                     sizeof(prog->subtype));
> +               if (size < 0) {
> +                       err = size;
> +                       goto free_prog;
> +               }
> +               /* prog->subtype is __GFP_ZERO */
> +               if (copy_from_user(&prog->subtype,
> +                                  u64_to_user_ptr(attr->prog_subtype), size)
> +                                  != 0)

It might be worth adding a comment here about how the ToCToU of the
check-then-copy doesn't matter in this case, since it's just a
future-proofing of bits, etc.

-Kees

-- 
Kees Cook
Pixel Security
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
