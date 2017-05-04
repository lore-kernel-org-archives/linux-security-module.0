From: stefanb@linux.vnet.ibm.com (Stefan Berger)
Date: Thu, 4 May 2017 13:33:41 -0400
Subject: [PATCH v3 1/3] tpm: vtpm_proxy: Implement new ioctl to get
	supported flags
In-Reply-To: <20170504173130.GA20449@obsidianresearch.com>
References: <1493909787-1848-1-git-send-email-stefanb@linux.vnet.ibm.com>
	<1493909787-1848-2-git-send-email-stefanb@linux.vnet.ibm.com>
	<20170504153416.GA15930@obsidianresearch.com>
	<56703d75-b238-0bad-386a-5b6963e250a1@linux.vnet.ibm.com>
	<20170504172042.GA19932@obsidianresearch.com>
	<cfa2642e-5b6e-de69-b1a0-ddcbfaf691c6@linux.vnet.ibm.com>
	<20170504173130.GA20449@obsidianresearch.com>
Message-ID: <08065914-2b96-ca1d-2fe0-344472ed9691@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 05/04/2017 01:31 PM, Jason Gunthorpe wrote:
> On Thu, May 04, 2017 at 01:28:17PM -0400, Stefan Berger wrote:
>
>>> So allowing request_locality to fail from userspace seems reasonable.
>> What's the best interface to use for this ?
> If locality support is enabled then send a request locality packet to
> userspace and block until return, just like command execution?

We would have to invent a command for that...


--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
