From: daniel@iogearbox.net (Daniel Borkmann)
Date: Wed, 18 Oct 2017 23:14:21 +0200
Subject: [PATCH net-next v7 1/5] bpf: Add file mode configuration into
	bpf maps
In-Reply-To: <20171018200026.146093-2-chenbofeng.kernel@gmail.com>
References: <20171018200026.146093-1-chenbofeng.kernel@gmail.com>
	<20171018200026.146093-2-chenbofeng.kernel@gmail.com>
Message-ID: <59E7C42D.1010402@iogearbox.net>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 10/18/2017 10:00 PM, Chenbo Feng wrote:
> From: Chenbo Feng <fengc@google.com>
>
> Introduce the map read/write flags to the eBPF syscalls that returns the
> map fd. The flags is used to set up the file mode when construct a new
> file descriptor for bpf maps. To not break the backward capability, the
> f_flags is set to O_RDWR if the flag passed by syscall is 0. Otherwise
> it should be O_RDONLY or O_WRONLY. When the userspace want to modify or
> read the map content, it will check the file mode to see if it is
> allowed to make the change.
>
> Signed-off-by: Chenbo Feng <fengc@google.com>
> Acked-by: Alexei Starovoitov <ast@kernel.org>

Acked-by: Daniel Borkmann <daniel@iogearbox.net>
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
