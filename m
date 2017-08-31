From: Alexander.Steffen@infineon.com (Alexander Steffen)
Date: Thu, 31 Aug 2017 18:58:17 +0200
Subject: [PATCH RESEND v3 0/2] tpm_tis_spi: Use DMA-safe memory
Message-ID: <20170831165819.13544-1-Alexander.Steffen@infineon.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

The documentation says that DMA-safe memory is required for SPI transfers.
The I/O buffers passed in by the caller can be allocated anywhere,
including on the stack, which is not DMA-safe. So the data needs to be
copied to separate, DMA-safe buffers.

We did not see any DMA-related issues on our test systems, even without
DMA-safe buffers. But this might simply be due to the fact that the SPI
transfer size is rather small, so our systems do not bother to set up DMA
transfers. Other systems might do so.

v2:
- Updated commit message with more explanations.

v3:
- Split into two patches, one for making the buffers DMA-safe and another
  for using only a single buffer.

Alexander Steffen (2):
  tpm_tis_spi: Use DMA-safe memory for SPI transfers
  tpm_tis_spi: Use a single buffer for SPI transfers

 drivers/char/tpm/tpm_tis_spi.c | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
