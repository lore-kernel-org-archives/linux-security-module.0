From: james.l.morris@oracle.com (James Morris)
Date: Fri, 20 Oct 2017 11:57:38 +1100 (AEDT)
Subject: [PATCH net-next v7 4/5] selinux: bpf: Add selinux check for eBPF
	syscall operations
In-Reply-To: <20171018200026.146093-5-chenbofeng.kernel@gmail.com>
References: <20171018200026.146093-1-chenbofeng.kernel@gmail.com>
	<20171018200026.146093-5-chenbofeng.kernel@gmail.com>
Message-ID: <alpine.LFD.2.20.1710201157130.11454@t440.gateway.2wire.net>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, 18 Oct 2017, Chenbo Feng wrote:

> From: Chenbo Feng <fengc@google.com>
> 
> Implement the actual checks introduced to eBPF related syscalls. This
> implementation use the security field inside bpf object to store a sid that
> identify the bpf object. And when processes try to access the object,
> selinux will check if processes have the right privileges. The creation
> of eBPF object are also checked at the general bpf check hook and new
> cmd introduced to eBPF domain can also be checked there.
> 
> Signed-off-by: Chenbo Feng <fengc@google.com>
> Acked-by: Alexei Starovoitov <ast@kernel.org>


Reviewed-by: James Morris <james.l.morris@oracle.com>

-- 
James Morris
<james.l.morris@oracle.com>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
