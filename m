From: james.l.morris@oracle.com (James Morris)
Date: Fri, 20 Oct 2017 11:54:20 +1100 (AEDT)
Subject: [PATCH net-next v7 3/5] security: bpf: Add LSM hooks for bpf
	object related syscall
In-Reply-To: <20171018200026.146093-4-chenbofeng.kernel@gmail.com>
References: <20171018200026.146093-1-chenbofeng.kernel@gmail.com>
	<20171018200026.146093-4-chenbofeng.kernel@gmail.com>
Message-ID: <alpine.LFD.2.20.1710201153050.11171@t440.gateway.2wire.net>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, 18 Oct 2017, Chenbo Feng wrote:

> From: Chenbo Feng <fengc@google.com>
> 
> Introduce several LSM hooks for the syscalls that will allow the
> userspace to access to eBPF object such as eBPF programs and eBPF maps.
> The security check is aimed to enforce a per object security protection
> for eBPF object so only processes with the right priviliges can
> read/write to a specific map or use a specific eBPF program. Besides
> that, a general security hook is added before the multiplexer of bpf
> syscall to check the cmd and the attribute used for the command. The
> actual security module can decide which command need to be checked and
> how the cmd should be checked.
> 
> Signed-off-by: Chenbo Feng <fengc@google.com>


Acked-by: James Morris <james.l.morris@oracle.com>

-- 
James Morris
<james.l.morris@oracle.com>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
