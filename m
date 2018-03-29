From: dave@stgolabs.net (Davidlohr Bueso)
Date: Wed, 28 Mar 2018 18:12:41 -0700
Subject: [REVIEW][PATCH 00/11] ipc: Fixing the pid namespace support
In-Reply-To: <87vadmobdw.fsf_-_@xmission.com>
References: <1520875093-18174-1-git-send-email-nagarathnam.muthusamy@oracle.com>
	<87vadzqqq6.fsf@xmission.com>
	<990e88fa-ab50-9645-b031-14e1afbf7ccc@oracle.com>
	<877eqejowd.fsf@xmission.com>
	<3a46a03d-e4dd-59b6-e25f-0020be1b1dc9@oracle.com>
	<87a7v2z2qa.fsf@xmission.com> <87vadmobdw.fsf_-_@xmission.com>
Message-ID: <20180329011241.v5kgiwbbayz425hk@linux-n805>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, 23 Mar 2018, Eric W. Biederman wrote:

>Still I would like to see this fixed and I plan on merging this code.

Yes, it needs fixed, but 1) there are pending issues (such as the extra atomics)
and 2) its late in the -rc cycle. Plus this issue has existed for 11 years without
the world ending, so I'm sure we can hold on until at least one more release.

Thanks,
Davidlohr
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
