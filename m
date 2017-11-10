From: mhiramat@kernel.org (Masami Hiramatsu)
Date: Fri, 10 Nov 2017 10:01:50 +0900
Subject: [RFC][PATCH] Lock down kprobes
In-Reply-To: <11786.1510246325@warthog.procyon.org.uk>
References: <11786.1510246325@warthog.procyon.org.uk>
Message-ID: <20171110100150.ae0062c1bdab4a2f18ddd68c@kernel.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi David,

On Thu, 09 Nov 2017 16:52:05 +0000
David Howells <dhowells@redhat.com> wrote:
> 
>     Lock down kprobes
>     
>     Disallow the creation of kprobes when the kernel is locked down by
>     preventing their registration.  This prevents kprobes from being used to
>     access kernel memory, either to make modifications or to steal crypto data.

Is that locked-down flag changed while running the kernel, or
only specified by boot parameter?
If that can happen while running, we have to take care of enabling/disabling
unregistering etc. too.

Thank you,


>     
>     Reported-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
>     Signed-off-by: David Howells <dhowells@redhat.com>
> 
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index a1606a4224e1..f06023b0936c 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -1530,6 +1530,9 @@ int register_kprobe(struct kprobe *p)
>  	struct module *probed_mod;
>  	kprobe_opcode_t *addr;
>  
> +	if (kernel_is_locked_down("Use of kprobes"))
> +		return -EPERM;
> +
>  	/* Adjust probe address from symbol */
>  	addr = kprobe_addr(p);
>  	if (IS_ERR(addr))


-- 
Masami Hiramatsu <mhiramat@kernel.org>
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
