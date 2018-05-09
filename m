From: alexei.starovoitov@gmail.com (Alexei Starovoitov)
Date: Tue, 8 May 2018 19:29:29 -0700
Subject: [PATCH v2 net-next 2/4] net: add skeleton of bpfilter kernel
	module
In-Reply-To: <20180507185124.GA18195@wotan.suse.de>
References: <20180503043604.1604587-1-ast@kernel.org>
	<20180503043604.1604587-3-ast@kernel.org>
	<20180507185124.GA18195@wotan.suse.de>
Message-ID: <20180509022928.elyxj6mohm2jud56@ast-mbp>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, May 07, 2018 at 06:51:24PM +0000, Luis R. Rodriguez wrote:
> > Notice that _binary_net_bpfilter_bpfilter_umh_start - end
> > is placed into .init.rodata section, so it's freed as soon as __init
> > function of bpfilter.ko is finished.
> > As part of __init the bpfilter.ko does first request/reply action
> > via two unix pipe provided by fork_usermode_blob() helper to
> > make sure that umh is healthy. If not it will kill it via pid.
> 
> It does this very fast, right away. On a really slow system how are you sure
> that this won't race and the execution of the check happens early on prior to
> letting the actual setup trigger? After all, we're calling the userpsace
> process in async mode. We could preempt it now.

I don't see an issue.
the kernel synchronously writes into a pipe. User space process reads.
Exactly the same as coredump logic with pipes.

> > +# a bit of elf magic to convert bpfilter_umh binary into a binary blob
> > +# inside bpfilter_umh.o elf file referenced by
> > +# _binary_net_bpfilter_bpfilter_umh_start symbol
> > +# which bpfilter_kern.c passes further into umh blob loader at run-time
> > +quiet_cmd_copy_umh = GEN $@
> > +      cmd_copy_umh = echo ':' > $(obj)/.bpfilter_umh.o.cmd; \
> > +      $(OBJCOPY) -I binary -O $(CONFIG_OUTPUT_FORMAT) \
> > +      -B `$(OBJDUMP) -f $<|grep architecture|cut -d, -f1|cut -d' ' -f2` \
> > +      --rename-section .data=.init.rodata $< $@
> 
> Cool, but so our expectation is that the compiler sets this symbol, how
> are we sure it will always be set?

Compiler doesn't set it. objcopy does.

> > +
> > +	if (__bpfilter_process_sockopt(NULL, 0, 0, 0, 0) != 0) {
> 
> See, here, what if the userspace process gets preemtped and we run this
> check afterwards? Is that possible?

User space is a normal task. It can sleep and can be single stepped with GDB.

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
