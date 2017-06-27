From: hch@infradead.org (Christoph Hellwig)
Date: Tue, 27 Jun 2017 10:51:18 -0700
Subject: [PATCH 3/3] Make LSM Writable Hooks a command line option
In-Reply-To: <20170627173323.11287-4-igor.stoppa@huawei.com>
References: <20170627173323.11287-1-igor.stoppa@huawei.com>
	<20170627173323.11287-4-igor.stoppa@huawei.com>
Message-ID: <20170627175118.GA14286@infradead.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, Jun 27, 2017 at 08:33:23PM +0300, Igor Stoppa wrote:
> From: Igor Stoppa <igor.stoppa@gmail.com>
> 
> This patch shows how it is possible to take advantage of pmalloc:
> instead of using the build-time option __lsm_ro_after_init, to decide if
> it is possible to keep the hooks modifiable, now this becomes a
> boot-time decision, based on the kernel command line.
> 
> This patch relies on:
> 
> "Convert security_hook_heads into explicit array of struct list_head"
> Author: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> 
> to break free from the static constraint imposed by the previous
> hardening model, based on __ro_after_init.
> 
> The default value is disabled, unless SE Linux debugging is turned on.

Can we please just force it to be read-only?
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
