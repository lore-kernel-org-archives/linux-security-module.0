From: roberto.sassu@huawei.com (Roberto Sassu)
Date: Wed, 15 Nov 2017 14:39:21 +0100
Subject: [USER SPACE][RFC][PATCH 0/5] ima: digest-list-tools package
Message-ID: <20171115133926.20108-1-roberto.sassu@huawei.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Recently, I published a patch set with title 'ima: digest list feature',
which allows users to upload to IMA a set of digests, that will be used as
reference values for measurement, appraisal and audit.

Although this patch set does not contain kernel patches, I would like to
publish it in the kernel mailing lists, so that people can have a better
understanding on how the digest list feature works, and can try it. The
kernel patches can be applied on top of the mainline kernel
(commit 37cb8e1f8) and https://patchwork.kernel.org/patch/10013259/.

I would also like to ask if it is fine to take code from the kernel without
including the original file. I tried to reuse as much code as possible, to
avoid two different implementations for kernel space and user space.

Thanks

Roberto


Roberto Sassu (5):
  digest-list-tools: headers
  digest-list-tools: library
  digest-list-tools: tools
  digest-list-tools: documentation
  digest-list-tools: package

-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
