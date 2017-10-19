From: alexei.starovoitov@gmail.com (Alexei Starovoitov)
Date: Thu, 19 Oct 2017 16:31:08 -0700
Subject: [PATCH 18/27] bpf: Restrict kernel image access functions when
	the kernel is locked down
In-Reply-To: <482.1508453314@warthog.procyon.org.uk>
References: <20171019221829.7m5nczg3ltqmhzom@ast-mbp>
	<150842463163.7923.11081723749106843698.stgit@warthog.procyon.org.uk>
	<150842476953.7923.18174368926573855810.stgit@warthog.procyon.org.uk>
	<482.1508453314@warthog.procyon.org.uk>
Message-ID: <20171019233105.5ladqpdf2me36j7q@ast-mbp>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, Oct 19, 2017 at 11:48:34PM +0100, David Howells wrote:
> Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> 
> > > @@ -65,6 +65,11 @@ BPF_CALL_3(bpf_probe_read, void *, dst, u32, size, const void *, unsafe_ptr)
> > >  {
> > >  	int ret;
> > >  
> > > +	if (kernel_is_locked_down("BPF")) {
> > > +		memset(dst, 0, size);
> > > +		return -EPERM;
> > > +	}
> >
> > That doesn't help the lockdown purpose.
> > If you don't trust the root the only way to prevent bpf read
> > memory is to disable the whole thing.
> > Have a single check in sys_bpf() to disallow everything if kernel_is_locked_down()
> > and don't add overhead to critical path like bpf_probe_read().
> 
> TBH, I've no idea how bpf does anything, so I can't say whether this is
> better, overkill or insufficient.

ok. To make it clear:
Nacked-by: Alexei Starovoitov <ast@kernel.org>
For the current patch.
Unnecessary checks for no good reason in performance critical
functions are not acceptable.

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
