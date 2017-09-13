From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 13 Sep 2017 09:33:24 -0700
Subject: [PATCH 1/2] vfs: constify path argument to
	kernel_read_file_from_path
In-Reply-To: <1505270734-4280-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1505270734-4280-1-git-send-email-zohar@linux.vnet.ibm.com>
Message-ID: <20170913163324.GA31421@infradead.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, Sep 12, 2017 at 10:45:33PM -0400, Mimi Zohar wrote:
> This patch constifies the path argument to kernel_read_file_from_path.
> 
> (Extracted from Helwig's patch.)

Feel free to skip this given that it's trivial and you misspelled my
name anyway :)
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
