From: alexei.starovoitov@gmail.com (Alexei Starovoitov)
Date: Sun, 8 Apr 2018 20:40:10 -0700
Subject: [GIT PULL] Kernel lockdown for secure boot
In-Reply-To: <20180408080742.GE7362@linux-l9pv.suse>
References: <CAADnVQLu5EZLJ1C9-dd4=K+sed6+38oy047+nqCMfuPFB=wttw@mail.gmail.com>
	<20180408080742.GE7362@linux-l9pv.suse>
Message-ID: <20180409034008.dyte7k5kgkbjh5is@ast-mbp.dhcp.thefacebook.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Sun, Apr 08, 2018 at 04:07:42PM +0800, joeyli wrote:
> 
> > If the only thing that folks are paranoid about is reading
> > arbitrary kernel memory with bpf_probe_read() helper
> > then preferred patch would be to disable it during verification
> > when in lockdown mode
> 
> Sorry for I didn't fully understand your idea...
> Do you mean that using bpf verifier to filter out bpf program that
> uses bpf_probe_read()?

Take a look bpf_get_trace_printk_proto().
Similarly we can add bpf_get_probe_read_proto() that
will return NULL if lockdown is on.
Then programs with bpf_probe_read() will be rejected by the verifier.

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
