From: mjg59@google.com (Matthew Garrett)
Date: Wed, 04 Apr 2018 04:31:46 +0000
Subject: [GIT PULL] Kernel lockdown for secure boot
In-Reply-To: <CAADnVQLu5EZLJ1C9-dd4=K+sed6+38oy047+nqCMfuPFB=wttw@mail.gmail.com>
References: <CAADnVQLu5EZLJ1C9-dd4=K+sed6+38oy047+nqCMfuPFB=wttw@mail.gmail.com>
Message-ID: <CACdnJuv8t3kS5BCowWQ7rMjL2K73913wX2-bb5HF0ddY3iaBHg@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, Apr 3, 2018 at 7:34 PM Alexei Starovoitov <
alexei.starovoitov@gmail.com> wrote:
> If the only thing that folks are paranoid about is reading
> arbitrary kernel memory with bpf_probe_read() helper
> then preferred patch would be to disable it during verification
> when in lockdown mode.
> No run-time overhead and android folks will be happy
> that lockdown doesn't break their work.
> They converted out-of-tree networking accounting
> module and corresponding user daemon to use bpf:

https://www.linuxplumbersconf.org/2017/ocw/system/presentations/4791/original/eBPF%20cgroup%20filters%20for%20data%20usage%20accounting%20on%20Android.pdf

An alternative would be to only disable kernel reads if the kernel contains
secrets that aren't supposed to be readable by root. If the keyring is
configured such that root can read everything, it seems like less of a
concern?
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
