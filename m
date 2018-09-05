From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Wed, 5 Sep 2018 14:12:56 +0300
Subject: [PATCH] tpm: fix response size validation in tpm_get_random()
In-Reply-To: <20180903011004.12161-1-jarkko.sakkinen@linux.intel.com>
References: <20180903011004.12161-1-jarkko.sakkinen@linux.intel.com>
Message-ID: <20180905111256.GA9696@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, Sep 03, 2018 at 04:10:04AM +0300, Jarkko Sakkinen wrote:
> When checking whether the response is large enough to be able to contain
> the received random bytes in tpm_get_random() and tpm2_get_random(),
> they fail to take account the header size, which should be added to the
> minimum size. This commit fixes this issue.
> 
> Cc: stable at vger.kernel.org
> Fixes: c659af78eb7b ("tpm: Check size of response before accessing data")
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

Stefan, you did the original commit. Does this look right to you?

/Jarkko
