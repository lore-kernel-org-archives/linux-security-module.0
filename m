Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Greylist: delayed 328 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 21 Nov 2023 02:08:06 PST
Received: from cavan.codon.org.uk (cavan.codon.org.uk [176.126.240.207])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19DD510E
	for <linux-security-module@vger.kernel.org>; Tue, 21 Nov 2023 02:08:06 -0800 (PST)
Received: by cavan.codon.org.uk (Postfix, from userid 1000)
	id 42480407E2; Tue, 21 Nov 2023 10:02:34 +0000 (GMT)
Date: Tue, 21 Nov 2023 10:02:34 +0000
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Paul Moore <paul@paul-moore.com>
Cc: linux-security-module@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: add an entry for the lockdown LSM
Message-ID: <ZVyAOvBQJKTkFB53@srcf.ucam.org>
References: <20231120215917.287595-2-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231120215917.287595-2-paul@paul-moore.com>

On Mon, Nov 20, 2023 at 04:59:18PM -0500, Paul Moore wrote:
> While lockdown has been present in the kernel for a while, it is
> missing a MAINTAINERS entry for some reason.
> 
> Cc: Matthew Garrett <mjg59@srcf.ucam.org>
> Signed-off-by: Paul Moore <paul@paul-moore.com>

Signed-off-by: Matthew Garrett <mjg59@srcf.ucam.org>
