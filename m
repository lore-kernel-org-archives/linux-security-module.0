From: luto@kernel.org (Andy Lutomirski)
Date: Tue, 3 Apr 2018 09:26:26 -0700
Subject: [GIT PULL] Kernel lockdown for secure boot
In-Reply-To: <20180403154156.f37wrzjhuvijzi2i@ast-mbp.dhcp.thefacebook.com>
References: <4136.1522452584@warthog.procyon.org.uk>
	<alpine.LRH.2.21.1803311145180.7769@namei.org>
	<186aeb7e-1225-4bb8-3ff5-863a1cde86de@kernel.org>
	<30459.1522739219@warthog.procyon.org.uk>
	<CALCETrUFOdrH5ShCCd8yguGjC2NtG8fJY7AW26HH467-02UVGA@mail.gmail.com>
	<20180403154156.f37wrzjhuvijzi2i@ast-mbp.dhcp.thefacebook.com>
Message-ID: <CALCETrX3D3jrr=Vq70H+ttdCKSevU-cC-cvZrfaoahEQoO7wzA@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, Apr 3, 2018 at 8:41 AM, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
> On Tue, Apr 03, 2018 at 08:11:07AM -0700, Andy Lutomirski wrote:
>> >
>> >> "bpf: Restrict kernel image access functions when the kernel is locked down":
>> >> This patch just sucks in general.
>> >
>> > Yes - but that's what Alexei Starovoitov specified.  bpf kind of sucks since
>> > it gives you unrestricted access to the kernel.
>>
>> bpf, in certain contexts, gives you unrestricted access to *reading*
>> kernel memory.  bpf should, under no circumstances, let you write to
>> the kernel unless you're using fault injection or similar.
>>
>> I'm surprised that Alexei acked this patch.  If something like XDP or
>> bpfilter starts becoming widely used, this patch will require a lot of
>> reworking to avoid breaking standard distros.
>
> my understanding was that this lockdown set attemps to disallow _reads_
> of kernel memory from anything, so first version of patch was adding
> run-time checks for bpf_probe_read() which is no-go
> and without this helper the bpf for tracing is losing a lot of its power,
> so the easiest is to disable it all.

Fair enough.

> I think lockdown suppose to disable xdp, bpfilter, nflog, raw sockets + pcap too
> otherwise even cap_net_admin can see traffic coming into host.
> Similarly kprobe, perf_event, ftrace should be off as well?
>

I'm reasonably sure that lockdown is not intended to be this far
reaching.  cap_net_admin can see traffic coming into the host, and I
don't think lockdown is intended to change that.

David, I think this is exactly why you need to define what "lockdown"
means.  As it stands, the best argument I've seen involves
"blacklisting", but that's a political thing and almost no one
involved has any ability to evaluate it.  Right now there's a series
of patches that check for "lockdown" and seem to disable things that
make someone uncomfortable.  That's not a good way to design a
security feature.
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
