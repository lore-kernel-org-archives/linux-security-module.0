From: daniel@iogearbox.net (Daniel Borkmann)
Date: Thu, 05 Oct 2017 18:12:51 +0200
Subject: [PATCH net-next 3/4] selinux: bpf: Add selinux check for eBPF
	syscall operations
In-Reply-To: <1507210095.27146.5.camel@tycho.nsa.gov>
References: <20171004182932.140028-1-chenbofeng.kernel@gmail.com>
	<20171004182932.140028-4-chenbofeng.kernel@gmail.com>
	<1507210095.27146.5.camel@tycho.nsa.gov>
Message-ID: <59D65A03.2000202@iogearbox.net>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 10/05/2017 03:28 PM, Stephen Smalley wrote:
[...]
>> +static int selinux_bpf_prog(struct bpf_prog *prog)
>> +{
>> +	u32 sid = current_sid();
>> +	struct bpf_security_struct *bpfsec;
>> +
>> +	bpfsec = prog->aux->security;
>
> I haven't looked closely at the bpf code, but is it guaranteed that
> prog->aux cannot be NULL here?  What's the difference in lifecycle for
> bpf_prog vs bpf_prog_aux?  Could the aux field be shared across progs
> created by different processes?

prog->aux cannot be NULL here, its lifetime is 1:1 with prog,
it holds slow-path auxiliary data unlike prog itself which is
additionally set to read-only after initial setup until teardown;
aux is also never shared across BPF progs, so always 1:1 relation
to prog itself.

Things that can be shared across multiple BPF programs and user
space processes are BPF maps themselves. From user space side
they can be passed via fd or pinned/retrieved from bpf fs, so
as currently implemented the void *security member you'd hold
in struct bpf_map would refer to the initial creator process of
the map here that doesn't strictly need to be alive anymore;
similarly for prog itself, when its shared between multiple
user space processes, *security ctx would point to the one that
installed it into the kernel initially.
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
