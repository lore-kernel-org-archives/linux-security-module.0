From: daniel@iogearbox.net (Daniel Borkmann)
Date: Tue, 17 Oct 2017 01:00:09 +0200
Subject: [PATCH net-next v6 2/5] bpf: Add tests for eBPF file mode
In-Reply-To: <20171016191135.8046-3-chenbofeng.kernel@gmail.com>
References: <20171016191135.8046-1-chenbofeng.kernel@gmail.com>
	<20171016191135.8046-3-chenbofeng.kernel@gmail.com>
Message-ID: <59E539F9.7080404@iogearbox.net>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 10/16/2017 09:11 PM, Chenbo Feng wrote:
> From: Chenbo Feng <fengc@google.com>
>
> Two related tests are added into bpf selftest to test read only map and
> write only map. The tests verified the read only and write only flags
> are working on hash maps.
>
> Signed-off-by: Chenbo Feng <fengc@google.com>

Acked-by: Daniel Borkmann <daniel@iogearbox.net>
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
