From: jlee@suse.com (joeyli)
Date: Thu, 5 Apr 2018 09:48:20 +0800
Subject: An actual suggestion (Re: [GIT PULL] Kernel lockdown for secure
	boot)
In-Reply-To: <15406.1522880367@warthog.procyon.org.uk>
References: <CAG48ez3edmZo1iFXqpvzOKNY0jLzcqa18KuoRrBaPyfp=7huZQ@mail.gmail.com>
	<CALCETrUVQLDC6_VEvuAbdCOuGrmcxohqTB6P8eyNojm9AryNkg@mail.gmail.com>
	<1119.1522858644@warthog.procyon.org.uk>
	<15406.1522880367@warthog.procyon.org.uk>
Message-ID: <20180405014820.GB7362@linux-l9pv.suse>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, Apr 04, 2018 at 11:19:27PM +0100, David Howells wrote:
> Jann Horn <jannh@google.com> wrote:
> 
> > > Uh, no.  bpf, for example, can be used to modify kernel memory.
> > 
> > I'm pretty sure bpf isn't supposed to be able to modify arbitrary
> > kernel memory. AFAIU if you can use BPF to write to arbitrary kernel
> > memory, that's a bug; with CAP_SYS_ADMIN, you can read from userspace,
> > write to userspace, and read from kernelspace, but you shouldn't be
> > able to write to kernelspace.
> 
> Ah - you may be right.  I seem to have misremembered what Joey Lee wrote in
> his patch description.
>

Sorry for it's my fault to misunderstood the behavoir of bpf with
CAP_SYS_ADMIN.

Joey Lee
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
