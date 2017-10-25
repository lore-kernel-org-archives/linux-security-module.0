From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Wed, 25 Oct 2017 13:46:33 -0600
Subject: [PATCH v2] tpm: use struct tpm_chip for tpm_chip_find_get()
In-Reply-To: <20171025193452.d4qa4dhacfgqejk7@linux.intel.com>
References: <20171025115508.5682-1-jarkko.sakkinen@linux.intel.com>
	<CANc+2y46q85+G1=9cXKW0R8FpGBqCuzkLnJzvSYFQ1S=ztKGew@mail.gmail.com>
	<20171025193452.d4qa4dhacfgqejk7@linux.intel.com>
Message-ID: <20171025194633.GB998@obsidianresearch.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

> struct tpm_chip *tpm_chip_find_get(u64 id)
> {
> 	struct tpm_chup *chip;
> 	struct tpm_chip *res = NULL;
> 	int chip_num = 0;
> 	int chip_prev;
> 
> 	mutex_lock(&idr_lock);
> 
> 	do {
> 		chip_prev = chip_num;
> 
> 		chip = idr_get_next(&dev_nums_idr, &chip_num);
> 
> 		if (chip && (!id || id == chip->id) && !tpm_try_get_ops(chip)) {
> 			res = chip;
> 			break;
> 		}
> 	} while (chip_prev != chip_num);
> 
> 	mutex_unlock(&idr_lock);
> 
> 	return res;
> }

?? The old version was correct, idr_find_slowpath is better than an
idr_get_next serach if you already know id.

PrasannaKumar's solution seems right, if we already have chip, then we
just need to lock it again:

struct tpm_chip *tpm_chip_find_get(struct tpm_chip *chip)
{
	struct tpm_chip *res = NULL;

	mutex_lock(&idr_lock);

	if (!chip) {
		int chip_num = 0;
		int chip_prev;

		do {
			chip_prev = chip_num;
			chip = idr_get_next(&dev_nums_idr, &chip_num);
			if (chip && !tpm_try_get_ops(chip)) {
				res = chip;
				break;
			}
		} while (chip_prev != chip_num);
	} else {
		if (!tpm_try_get_ops(chip))
			res = chip;
	}

	mutex_unlock(&idr_lock);

	return res;
}

Jason
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
