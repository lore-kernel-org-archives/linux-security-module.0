From: mcgrof@kernel.org (Luis R. Rodriguez)
Date: Tue, 3 Apr 2018 10:06:10 -0700
Subject: [RFC PATCH v1] fw_lockdown: new micro LSM module to prevent
	loading unsigned firmware
In-Reply-To: <20180403165627.GW30543@wotan.suse.de>
References: <1510347775.3549.2.camel@linux.vnet.ibm.com>
	<21dd4b88-f6e7-f6bb-e34d-ba8ef3755622@kernel.org>
	<20180403165627.GW30543@wotan.suse.de>
Message-ID: <CAB=NE6UZbBWn1WCfM5in1w32ZXNaV25_uz+=TVyu4Y-35Rv72A@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, Apr 3, 2018 at 9:56 AM, Luis R. Rodriguez <mcgrof@kernel.org> wrote:
> The biggest thing which has changed since then is that we decided to *not*
> support or streamline generic firmware signing (non-IMA) for now for a few
> reasons [0] [1] which are important to re-iterate as these are easy to forget,
> and AFAICT not documented anywhere.

And the URLs...

[0] https://lkml.kernel.org/r/20171204195155.GU729 at wotan.suse.de
[1] https://lkml.kernel.org/r/20171207153209.5da771a9 at alans-desktop

  Luis
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
