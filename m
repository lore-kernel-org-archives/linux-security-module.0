From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Thu, 23 Nov 2017 06:55:36 -0500
Subject: [RFC PATCH v2] fw_lockdown: new micro LSM module to prevent
	loading unsigned firmware
In-Reply-To: <20171122185837.GG729@wotan.suse.de>
References: <1510573414.3404.109.camel@linux.vnet.ibm.com>
	<1511220268.4729.134.camel@linux.vnet.ibm.com>
	<20171122185837.GG729@wotan.suse.de>
Message-ID: <1511438136.30063.52.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, 2017-11-22 at 19:58 +0100, Luis R. Rodriguez wrote:

> I've frankly have grown tired of pushing firmware signing just for the sake of
> the fact that I needed it for cfg80211, but now that its out of the way and
> we open coded it, its no longer a requirement on my part. 

As the keys CFG80211_REQUIRE_SIGNED_REGDB are built into the kernel
image, they would be included in the kernel image signature.

As I previously asked?https://lkml.org/lkml/2017/11/15/679, how are
the keys located in the CFG80211_EXTRA_REGDB_KEYDIR keyring trusted?
?The keyring does not validate the certificate signatures, before
loading the keys on the firmware keyring. ?It explicitly bypasses the
certificate signature validation.

Mimi

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
