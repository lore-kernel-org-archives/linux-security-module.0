Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491B520C472
	for <linux-security-module@vger.kernel.org>; Wed, 12 Mar 2025 08:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741768415; cv=none; b=NiJ6CDNDFgH3Y52TM8eHGMPvuQvVpGsZi3sq8h+QVFLGIN3UMyozwyynwhWtggnk1Q2xD6GX2VXmKfr46lEsC0UvVEGZRYBVxmgBIZbEz4e0zNGEZvJriV/luZMFew2IHwGQk6hlK8+/BQfHhESnAg3LRj2FVlDQsLp8flLn/Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741768415; c=relaxed/simple;
	bh=MALd7c1iFGeOmtrUZpXjyp/b2Oy59fdJ87z0y3tlBL8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=K9Mlv5J4p0V9EuDeDWM0jCZwDOl7Y9SAMnxcnqjh83RjFJ7XZFiMITYWLWnJfX3bz15RZ9QbNzpfYJDTRV01EhyrHTRflVv5tRepr+qCVahzBvx6bSNWGdtWaPBCy/IhGYrQPvwB95yCAx85oj2voQKmpjIryIpy/9HPiHc/+lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EnUqRTKO; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EnUqRTKO"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43948021a45so54376185e9.1
        for <linux-security-module@vger.kernel.org>; Wed, 12 Mar 2025 01:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741768412; x=1742373212; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z0qslrJHoEFmxrXCxL5AmhXfE1MW6MVR0bcrLjgm+RY=;
        b=EnUqRTKOWX2l5M1gJHY2MfHAEhApQxC9CUosm7Ll6rrHMetNSPB4RMiVVdG4Qb/NUh
         mqxt0VixnU9YLkiI6YFOzEUlgub8N7+uvVJzV1Lz6t3aEpfTsmmtS3qukIcN26liOQvW
         7VAagji2XYONT/SAlq9MXpxxQP9dZWTJVjzp7fgj9ROdjxrSRONX6hw17znwjN2zttrt
         m2H5yI7EutSwEQ/BOGANcoUh8AZ4tkk7wIlhsJqcwIyLB8q2rsleyiMZbLfvGaLIGR/M
         IJDTKx7AnFM3CIgS7AkUsV5INOWUotHW3SKovkWJWc7JEdPU8AJ+YGulmHMW5Si/A9rP
         So5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741768412; x=1742373212;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z0qslrJHoEFmxrXCxL5AmhXfE1MW6MVR0bcrLjgm+RY=;
        b=asRfxgxuzpREi/GKNrPqNeKBhvka3e8uiMXwy2qXZXrvpfRTvl5YdCtdcE84QDWJLR
         m+rqY+dNgmwvunWcOZC327JpPdxSBKadqBMG7r84EuCxpAN2yPZacavLoDG8H/5mHKht
         mqEzRxQX1o0QM9ROHkiafgWkgy6TqkmdfijGwmXZakZIxOxunW7W+rPx0orVKfaRLUyZ
         KFebU9elHFfLlj+afyRQWzDRdTwolyfI202WWGTll+DYO3uzMHpDuBPRkvaJ4nQ7usn1
         pMmAe86ryomnAiKc1sBl8MnghZxdV7CVLZktWSpL9jxAWYVXwh7zTH3gIauetEVrGGEK
         g1EA==
X-Gm-Message-State: AOJu0YwHol9zE1zz2M8J7tXZZarN2xIhJrOJmYTADgt0hjKzBR34WwiT
	m/rIumfeZXJCzW6y4pGXJ/QpfQ7zVw9wMYHpkaMTxyXwiFUx4MbsIMkTAVWaWbE=
X-Gm-Gg: ASbGncvFwtAtl/ClbaitQoY5BWjBDBNN2wN7PtoatR1QwDaeENAioNo0y1LpwQZhf5x
	ugU3ou6HH6lULHmphWpB+jW1eNvSf09XD9vktfaErv4JkwJ2kiTMJIR1a8LO9lJXQGe9h79idMO
	XPRzHP2So7tWHw0by5GPUJQXK/VbUKi2/cmVl2BtRiuY5UOwbh1t/6U5G6wPY3BA7YEtNhqbaVo
	UzEOsDyYcJGfwAT1vldxAuqunIhUf8SfZm9+lT4xecNkdAsAAvL6Bf1tgGnlDkV0l0ymcs7lLYo
	IUziAsxLBtYDlm2wmWz6q4ElJ8PvnJ788Z2lAZYhq50ZC41J8Q==
X-Google-Smtp-Source: AGHT+IGODAtUtyyX+lJngat6ov5wFe7pbj8GxC0siTxS6hdOskyLRBbRTp1EbVbsyjhnJ1wiXClHZA==
X-Received: by 2002:a05:6000:144b:b0:391:4743:6de4 with SMTP id ffacd0b85a97d-3914752b2dbmr11096557f8f.50.1741768412572;
        Wed, 12 Mar 2025 01:33:32 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43d0a8d0ab1sm13750915e9.34.2025.03.12.01.33.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 01:33:32 -0700 (PDT)
Date: Wed, 12 Mar 2025 11:33:29 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: linux-security-module@vger.kernel.org
Subject: [bug report] landlock: Add AUDIT_LANDLOCK_DOMAIN and log domain
 status
Message-ID: <2425110b-b5ca-4b33-bf75-e6fca0b0de63@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hello Mickaël Salaün,

Commit 96cc6f48a8e4 ("landlock: Add AUDIT_LANDLOCK_DOMAIN and log
domain status") from Mar 8, 2025 (linux-next), leads to the following
Smatch static checker warning:

	security/landlock/domain.c:66 get_current_exe()
	warn: 'size' unsigned <= 0

security/landlock/domain.c
    39 static const void *get_current_exe(const char **const exe_str,
    40                                    size_t *const exe_size)
    41 {
    42         const size_t buffer_size = LANDLOCK_PATH_MAX_SIZE;
    43         struct mm_struct *mm = current->mm;
    44         struct file *file __free(fput) = NULL;
    45         char *buffer __free(kfree) = NULL;
    46         const char *exe;
    47         size_t size;
    48 
    49         if (!mm)
    50                 return NULL;
    51 
    52         file = get_mm_exe_file(mm);
    53         if (!file)
    54                 return NULL;
    55 
    56         buffer = kmalloc(buffer_size, GFP_KERNEL);
    57         if (!buffer)
    58                 return ERR_PTR(-ENOMEM);
    59 
    60         exe = d_path(&file->f_path, buffer, buffer_size);
    61         if (WARN_ON_ONCE(IS_ERR(exe)))
    62                 /* Should never happen according to LANDLOCK_PATH_MAX_SIZE. */
    63                 return ERR_CAST(exe);
    64 
    65         size = buffer + buffer_size - exe;

d_path() takes a buffer and returns exe which is a pointer to the
somewhere in the middle of buffer.

--> 66         if (WARN_ON_ONCE(size <= 0))

So size can't be negative.  And also size is declared as unsigned so it
can't be negative for that reason either.

    67                 return ERR_PTR(-ENAMETOOLONG);
    68 
    69         *exe_size = size;
    70         *exe_str = exe;
    71         return no_free_ptr(buffer);
    72 }

regards,
dan carpenter
