From: james.l.morris@oracle.com (James Morris)
Date: Thu, 12 Oct 2017 11:31:34 +1100 (AEDT)
Subject: [PATCH net-next 2/4] security: bpf: Add LSM hooks for bpf object
	related syscall
In-Reply-To: <20171004182932.140028-3-chenbofeng.kernel@gmail.com>
References: <20171004182932.140028-1-chenbofeng.kernel@gmail.com>
	<20171004182932.140028-3-chenbofeng.kernel@gmail.com>
Message-ID: <alpine.LFD.2.20.1710121129510.17334@t440.gateway.2wire.net>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, 4 Oct 2017, Chenbo Feng wrote:

>  int bpf_map_new_fd(struct bpf_map *map, int flags)
>  {
> +	if (security_bpf_map(map, OPEN_FMODE(flags)))
> +		return -EPERM;
> +

Don't hardcode -EPERM here, return the actual error from 
security_bpf_map().

> +	if (security_bpf_prog(prog))
> +		return -EPERM;
> +

Same.

> +	err = security_bpf(cmd, &attr, size);
> +	if (err)
> +		return -EPERM;

Same.


- James

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
