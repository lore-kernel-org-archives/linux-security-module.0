From: alexei.starovoitov@gmail.com (Alexei Starovoitov)
Date: Tue, 3 Apr 2018 08:41:58 -0700
Subject: [GIT PULL] Kernel lockdown for secure boot
In-Reply-To: <CALCETrUFOdrH5ShCCd8yguGjC2NtG8fJY7AW26HH467-02UVGA@mail.gmail.com>
References: <4136.1522452584@warthog.procyon.org.uk>
	<alpine.LRH.2.21.1803311145180.7769@namei.org>
	<186aeb7e-1225-4bb8-3ff5-863a1cde86de@kernel.org>
	<30459.1522739219@warthog.procyon.org.uk>
	<CALCETrUFOdrH5ShCCd8yguGjC2NtG8fJY7AW26HH467-02UVGA@mail.gmail.com>
Message-ID: <20180403154156.f37wrzjhuvijzi2i@ast-mbp.dhcp.thefacebook.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, Apr 03, 2018 at 08:11:07AM -0700, Andy Lutomirski wrote:
> >
> >> "bpf: Restrict kernel image access functions when the kernel is locked down":
> >> This patch just sucks in general.
> >
> > Yes - but that's what Alexei Starovoitov specified.  bpf kind of sucks since
> > it gives you unrestricted access to the kernel.
> 
> bpf, in certain contexts, gives you unrestricted access to *reading*
> kernel memory.  bpf should, under no circumstances, let you write to
> the kernel unless you're using fault injection or similar.
> 
> I'm surprised that Alexei acked this patch.  If something like XDP or
> bpfilter starts becoming widely used, this patch will require a lot of
> reworking to avoid breaking standard distros.

my understanding was that this lockdown set attemps to disallow _reads_
of kernel memory from anything, so first version of patch was adding
run-time checks for bpf_probe_read() which is no-go
and without this helper the bpf for tracing is losing a lot of its power,
so the easiest is to disable it all.
I think lockdown suppose to disable xdp, bpfilter, nflog, raw sockets + pcap too
otherwise even cap_net_admin can see traffic coming into host.
Similarly kprobe, perf_event, ftrace should be off as well?

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
