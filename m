From: jlee@suse.com (joeyli)
Date: Wed, 12 Apr 2017 22:57:36 +0800
Subject: [PATCH 20/24] bpf: Restrict kernel image access functions when
	the kernel is locked down
In-Reply-To: <149142344547.5101.4518618716303032193.stgit@warthog.procyon.org.uk>
References: <149142326734.5101.4596394505987813763.stgit@warthog.procyon.org.uk>
	<149142344547.5101.4518618716303032193.stgit@warthog.procyon.org.uk>
Message-ID: <20170412145736.GF18270@linux-l9pv.suse>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi David,

First, thanks for your help to send out this series.

On Wed, Apr 05, 2017 at 09:17:25PM +0100, David Howells wrote:
> From: Chun-Yi Lee <jlee@suse.com>
> 
> There are some bpf functions can be used to read kernel memory:
> bpf_probe_read, bpf_probe_write_user and bpf_trace_printk.  These allow
> private keys in kernel memory (e.g. the hibernation image signing key) to
> be read by an eBPF program.  Prohibit those functions when the kernel is
> locked down.
> 
> Signed-off-by: Chun-Yi Lee <jlee@suse.com>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: netdev at vger.kernel.org

This patch is used with hibernation signature verification. I suggest
that we can remove this patch from your series because we just lock
down the hibernation function until hibernation verification get
accepted.

On the other hand, we are trying to enhance the bpf verifier to
prevent bpf print reads specific memory addresses that have sensitive
data.

Thanks a lot!
Joey Lee
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
