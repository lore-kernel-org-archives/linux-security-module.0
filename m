From: alexei.starovoitov@gmail.com (Alexei Starovoitov)
Date: Thu, 6 Apr 2017 08:29:09 -0400
Subject: [PATCH 20/24] bpf: Restrict kernel image access functions when
	the kernel is locked down
In-Reply-To: <149142344547.5101.4518618716303032193.stgit@warthog.procyon.org.uk>
References: <149142326734.5101.4596394505987813763.stgit@warthog.procyon.org.uk>
	<149142344547.5101.4518618716303032193.stgit@warthog.procyon.org.uk>
Message-ID: <20170406122907.GA53880@ast-mbp.thefacebook.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, Apr 05, 2017 at 09:17:25PM +0100, David Howells wrote:
> From: Chun-Yi Lee <jlee@suse.com>
> 
> There are some bpf functions can be used to read kernel memory:
> bpf_probe_read, bpf_probe_write_user and bpf_trace_printk.  These allow
> private keys in kernel memory (e.g. the hibernation image signing key) to
> be read by an eBPF program.  Prohibit those functions when the kernel is
> locked down.
> 
> Signed-off-by: Chun-Yi Lee <jlee@suse.com>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: netdev at vger.kernel.org
> ---
> 
>  kernel/trace/bpf_trace.c |   11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index cee9802cf3e0..7fde851f207b 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -65,6 +65,11 @@ BPF_CALL_3(bpf_probe_read, void *, dst, u32, size, const void *, unsafe_ptr)
>  {
>  	int ret;
>  
> +	if (kernel_is_locked_down()) {
> +		memset(dst, 0, size);
> +		return -EPERM;
> +	}

this will obviously break the program. How about disabling loading tracing
programs during the lockdown completely?

Also is there a description of what this lockdown trying to accomplish?
The cover letter is scarce in details.

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
