From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Fri, 24 Aug 2018 09:30:15 +0300
Subject: [PATCH 03/23] TPM: Provide a platform driver for the user
	emulator driver
In-Reply-To: <153486702979.13066.16900998092976336647.stgit@warthog.procyon.org.uk>
References: <153486700916.13066.12870860668352070081.stgit@warthog.procyon.org.uk>
	<153486702979.13066.16900998092976336647.stgit@warthog.procyon.org.uk>
Message-ID: <20180824063015.GE3584@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, Aug 21, 2018 at 04:57:09PM +0100, David Howells wrote:
> Provide a platform driver for the user emulator driver.  This seems to be
> necessary to stop tpm_chip_find_get() from blowing up because it assumes
> unconditionally that any device will have a driver attached:
> 
> 		if (try_module_get(pos->dev->driver->owner)) {
> 
> However, this doesn't then work right because if I remove the TPM device and
> re-add it, the tpm ID isn't recycled (ie, /dev/tpm0 becomes unavailable and
> the new TPM is /dev/tpm1).
> 
> Signed-off-by: David Howells <dhowells@redhat.com>

Again, a duplicate.

/Jarkko
