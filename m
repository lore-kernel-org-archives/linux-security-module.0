From: hch@infradead.org (Christoph Hellwig)
Date: Mon, 12 Jun 2017 23:34:46 -0700
Subject: [PATCH 05/11] Creation of "check_vmflags" LSM hook
In-Reply-To: <1497286620-15027-6-git-send-email-s.mesoraca16@gmail.com>
References: <1497286620-15027-1-git-send-email-s.mesoraca16@gmail.com>
	<1497286620-15027-6-git-send-email-s.mesoraca16@gmail.com>
Message-ID: <20170613063446.GA12537@infradead.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, Jun 12, 2017 at 06:56:54PM +0200, Salvatore Mesoraca wrote:
> Creation of a new LSM hook to check if a given configuration of vmflags,
> for a new memory allocation request, should be allowed or not.
> It's placed in "do_mmap", "do_brk_flags" and "__install_special_mapping".

Please always post the whole series including the users, thanks.
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
