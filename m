From: jlee@suse.com (joeyli)
Date: Fri, 20 Oct 2017 10:47:32 +0800
Subject: [PATCH 18/27] bpf: Restrict kernel image access functions when
	the kernel is locked down
In-Reply-To: <20171019221829.7m5nczg3ltqmhzom@ast-mbp>
References: <150842463163.7923.11081723749106843698.stgit@warthog.procyon.org.uk>
	<150842476953.7923.18174368926573855810.stgit@warthog.procyon.org.uk>
	<20171019221829.7m5nczg3ltqmhzom@ast-mbp>
Message-ID: <20171020024732.GJ3285@linux-l9pv.suse>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi Alexei,

Thanks for your review! 

On Thu, Oct 19, 2017 at 03:18:30PM -0700, Alexei Starovoitov wrote:
> On Thu, Oct 19, 2017 at 03:52:49PM +0100, David Howells wrote:
> > From: Chun-Yi Lee <jlee@suse.com>
> > 
> > There are some bpf functions can be used to read kernel memory:
> > bpf_probe_read, bpf_probe_write_user and bpf_trace_printk.  These allow
> > private keys in kernel memory (e.g. the hibernation image signing key) to
> > be read by an eBPF program.  Prohibit those functions when the kernel is
> > locked down.
> > 
> > Signed-off-by: Chun-Yi Lee <jlee@suse.com>
> > Signed-off-by: David Howells <dhowells@redhat.com>
> > cc: netdev at vger.kernel.org
> > ---
> > 
> >  kernel/trace/bpf_trace.c |   11 +++++++++++
> >  1 file changed, 11 insertions(+)
> > 
> > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > index dc498b605d5d..35e85a3fdb37 100644
> > --- a/kernel/trace/bpf_trace.c
> > +++ b/kernel/trace/bpf_trace.c
> > @@ -65,6 +65,11 @@ BPF_CALL_3(bpf_probe_read, void *, dst, u32, size, const void *, unsafe_ptr)
> >  {
> >  	int ret;
> >  
> > +	if (kernel_is_locked_down("BPF")) {
> > +		memset(dst, 0, size);
> > +		return -EPERM;
> > +	}
> 
> That doesn't help the lockdown purpose.
> If you don't trust the root the only way to prevent bpf read
> memory is to disable the whole thing.

Not totally untrust root, I don't want that root reads
arbitrary memory address through bpf.

Is it not enough to lock down bpf_probe_read, bpf_probe_write_user
and bpf_trace_printk?

> Have a single check in sys_bpf() to disallow everything if kernel_is_locked_down()
> and don't add overhead to critical path like bpf_probe_read().
>

Yes, it give overhead to bpf_probe_read but it prevents arbitrary
memory read.

Another idea is signing bpf bytecode then verifying signture when
loading to kernel. 

Thanks a lot!
Joey Lee 
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
