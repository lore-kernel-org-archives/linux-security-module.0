Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C912264D6
	for <linux-security-module@vger.kernel.org>; Mon,  8 Sep 2025 11:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757330119; cv=none; b=G5lqLQLk7tJBmVovvlEN6eFGPF9gdO/b9GsNiAqL99UgmmyTwAZqdSwTm1rwpjX7D6ArWkRf5iheoVWmziZ8Gi523l6ldchvq4hT5T2IITQPOoeKrvZG7O/3Wz/GbD8azGJtRf3Ddia2qsR04pWoyaj5N9RRv9DA5wo3W8p9rwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757330119; c=relaxed/simple;
	bh=aUVE8FthtNrnN/ESZ4IO98xDT5XV5Larg3g6OfQcICU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=sZz0aOlYP7NFFKm/c6ITLXKL0K7YPix23gVpGZyXsd8WhBEWtET74tjfsn93fjmW75MzeU9FC+dSs3htk7EL6tl/lPo/sPmzPis/YicpkaYJYdvpIcG0aidn/Ym4Rwtfte/i5Pb3Swkq++vARtBhpmqFveFMldSqnCzn5OqEZfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g/zYH3pW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g/zYH3pW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757330116;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wwUZv7xn5kwJDxXIChe0wNGvkZwPHl5q6JPSLW8gUe4=;
	b=g/zYH3pWwgYESi+bNVAO5WXcHwHKLtk8FIPJn+fKI6lPQddYw5gsxlVBP2mwldFwv5tEdH
	IWmGQHUfooawd2t2wAw5FFf0vN/LfPmKOvoSCcN7mpKgvjHCyoz49oynCv4mJHLaaBZOdA
	qy/zmBu6fmEnFKlsmOWSWhARKPShw6Y=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-323-wnPjgatjNSS-_dLnth3beg-1; Mon, 08 Sep 2025 07:15:15 -0400
X-MC-Unique: wnPjgatjNSS-_dLnth3beg-1
X-Mimecast-MFC-AGG-ID: wnPjgatjNSS-_dLnth3beg_1757330115
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-77264a9408cso9118625b3a.3
        for <linux-security-module@vger.kernel.org>; Mon, 08 Sep 2025 04:15:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757330114; x=1757934914;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wwUZv7xn5kwJDxXIChe0wNGvkZwPHl5q6JPSLW8gUe4=;
        b=HlfhLGzTukyj9wQIs2y8o382PSgL0CppoQR4COPeVHBgfXwCkLKz6SrteqFw+FcIfM
         x7JUa06cJpdHuzZhEFT3OaYQ3tAchIXRzlmkzmiqmEpkgeuZHXO3j+gXCup3uVNJgUyk
         CXQMUEb44qyPWuCJ/8jCwkcSK2HlAbGPFXc7w2xdanPz1XizUk/ITRzjQnJP3RwdTIzK
         HUc4lFxg5Q5RMG2tS0+UrR+g+FMNh9s3EQY+B+N6Q1Z0ZS0h9pQ2DTZkWZnuJdCNGNuu
         y9T+31a3xxxEN1npXiL0OHMXOLhwt7fgVpBssNaz9ogCdjRzWWs+I8AfBEDm1SOvRqSH
         FBlg==
X-Forwarded-Encrypted: i=1; AJvYcCXRxQV+X8VVUYMLMPI7S+pQPGsDDXzPZ5JLl13l5MnFyUG72VCLhe77NFoqRIrO8kHSG479VmfB3pdjZNRlz4iqjjgeVJA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8x4cdIAkFlo/Gzs715MfVAPhw2PLkCxCf+aDCKStcoC5jflB4
	MB2Pfdfdt8YEoMQWQinPLvpoKDkwD9Un4flqjY86rJeOjMdn6DhMOaHbVQ+Hc4C/qZMRgclohlF
	IrcrFXPbbfoYmxr59gmOX5btK7zK3ajsGLYv9M+8Bqtk8V0pKDMwyfo3MXJ3Cc2gYbXb+krRb1W
	Cc5w==
X-Gm-Gg: ASbGncty2DcNp1txGTn8YMEk9/2QyAFh5DZ6e7PPhGP6W/+dfuJn9TEcAB5Lev6wfKO
	LyyXMsIBgkH2To11bHmNd+su1l+OmQ+r7ngXtxOiIWKQQLVJ3OhXXUxZPpCkn9DooWBV5TIawfZ
	1oSNyCdJiYqsHWhrU3tvGncgJJCtxFXxpHzOxVWxps2iBUhU50GHPABGKtD8ScLxxLAgB028tNU
	d8QXGNDdWin59kHW4XacxM0NfdgEil2kjr8dK4NX6ASoiENgQPmiSJtpWi5r0XsZ0Ajbj0ICXm9
	/c+9rN2yC3hWET0Ga2TL8kqbOAlMqfA=
X-Received: by 2002:a05:6a00:4613:b0:772:5b74:c26e with SMTP id d2e1a72fcca58-7742dea660amr11162777b3a.18.1757330114610;
        Mon, 08 Sep 2025 04:15:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE1AQ3ExSzLUZMdMo+aC42rYKm4I5V31Fv7OTUPdi28epWE4qludHltIl7qqNhPZKbMu+fugA==
X-Received: by 2002:a05:6a00:4613:b0:772:5b74:c26e with SMTP id d2e1a72fcca58-7742dea660amr11162739b3a.18.1757330114113;
        Mon, 08 Sep 2025 04:15:14 -0700 (PDT)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a4e1ca7sm29403639b3a.71.2025.09.08.04.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 04:15:13 -0700 (PDT)
Date: Mon, 8 Sep 2025 19:12:07 +0800
From: Coiby Xu <coxu@redhat.com>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org, 
	Roberto Sassu <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
	Eric Snowberg <eric.snowberg@oracle.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ima: don't clear IMA_DIGSIG flag when setting non-IMA
 xattr
Message-ID: <53wb5tzech2k4k25xy2heq7ohmp2elw2a7l4x3nfk6fajfydur@5thsinydau5x>
References: <20250902042515.759750-1-coxu@redhat.com>
 <d252b04934908e7e65a3299bfeffc282c7b0b12f.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <d252b04934908e7e65a3299bfeffc282c7b0b12f.camel@linux.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: d7f-Z6ijAZK2rspY8G2KB4K_5dK7sskqfOQ79wvIWiM_1757330115
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Thu, Sep 04, 2025 at 10:41:42PM -0400, Mimi Zohar wrote:
>On Tue, 2025-09-02 at 12:25 +0800, Coiby Xu wrote:
>> Currently when both IMA and EVM are in fix mode, the IMA signature will
>> be reset to IMA hash if a program first stores IMA signature in
>> security.ima and then sets security.selinux for a file. For example, on
>> Fedora, after booting the kernel with "ima_appraise=fix evm=fix
>> ima_policy=appraise_tcb" and installing rpm-plugin-ima, reinstalling a
>> package will not make good reference IMA signature generated. Instead
>> IMA hash is generated,
>>     # getfattr -m - -d -e hex /usr/bin/bash
>>     # file: usr/bin/bash
>>     security.ima=0x0404...
>>
>> This happens because when setting selinux.selinux, the IMA_DIGSIG flag
>> that had been set early was cleared. As a result, IMA hash is generated
>> when the file is closed.
>>
>> Here's a minimal C reproducer,
>>
>>     #include <stdio.h>
>>     #include <sys/xattr.h>
>>     #include <fcntl.h>
>>     #include <unistd.h>
>>     #include <string.h>
>>     #include <stdlib.h>
>>
>>     int main() {
>>         const char* file_path = "/usr/sbin/test_binary";
>>         const char* hex_string = "030204d33204490066306402304";
>>         int length = strlen(hex_string);
>>         char* ima_attr_value;
>>         int fd;
>>
>>         fd = open(file_path, O_WRONLY|O_CREAT|O_EXCL, 0644);
>>         if (fd == -1) {
>>             perror("Error opening file");
>>             return 1;
>>         }
>>
>>         ima_attr_value = (char*)malloc(length / 2 );
>>         for (int i = 0, j = 0; i < length; i += 2, j++) {
>>             sscanf(hex_string + i, "%2hhx", &ima_attr_value[j]);
>>         }
>>
>>         if (fsetxattr(fd, "security.ima", ima_attr_value, length/2, 0) == -1) {
>>             perror("Error setting extended attribute");
>>             close(fd);
>>             return 1;
>>         }
>>
>>         const char* selinux_value= "system_u:object_r:bin_t:s0";
>>         if (fsetxattr(fd, "security.selinux", selinux_value, strlen(selinux_value), 0) == -1) {
>>             perror("Error setting extended attribute");
>>             close(fd);
>>             return 1;
>>         }
>>
>>         close(fd);
>>
>>         return 0;
>>     }
>>
>> Signed-off-by: Coiby Xu <coxu@redhat.com>
>
>Thanks, Coiby.  Agreed, the ability to clear the IMA_DIGSIG flag should be
>limited to security.ima xattr and probably security.evm xattr.  Writing other
>security xattrs should not affect the IMA_DIGSIG flag.

Thanks for confirming it!

>
>Even without an IMA appraise policy, the security xattrs are written out to the
>filesystem, but the IMA_DIGSIG flag is not cached.

It seems I miss some context for the above sentence. If no IMA policy is
configured, no ima_iint_cache will be created. If you mean non-appraisal
policy, will not caching IMA_DIGSIG flag cause any problem?

>
>Please document the tristate values:
>0: clear IMA_DIGSIG
>1: set IMA_DIGSIG
>-1: don't change IMA_DIGSIG

Addressed in v2. Thanks for the suggestion!

>
>> ---
>>  security/integrity/ima/ima_appraise.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
>> index f435eff4667f..fc82161f8b30 100644
>> --- a/security/integrity/ima/ima_appraise.c
>> +++ b/security/integrity/ima/ima_appraise.c
>> @@ -708,7 +708,7 @@ static void ima_reset_appraise_flags(struct inode *inode, int digsig)
>>  	set_bit(IMA_CHANGE_XATTR, &iint->atomic_flags);
>>  	if (digsig)
>>  		set_bit(IMA_DIGSIG, &iint->atomic_flags);
>
>This matches both -1 and 1.  Test "digsig == 1" here.
>
>> -	else
>> +	else if (digsig != -1)
>
>and test "digsig == 0" here.
>
>>  		clear_bit(IMA_DIGSIG, &iint->atomic_flags);
>>  }
>>
>> @@ -794,6 +794,8 @@ static int ima_inode_setxattr(struct mnt_idmap *idmap, struct dentry *dentry,
>>  		digsig = (xvalue->type == EVM_IMA_XATTR_DIGSIG);
>>  	} else if (!strcmp(xattr_name, XATTR_NAME_EVM) && xattr_value_len > 0) {
>>  		digsig = (xvalue->type == EVM_XATTR_PORTABLE_DIGSIG);
>> +	} else if (result != 1) {
>
>The "if (result != 1)" test is redundant.

I've fixed them in v2. Thanks for reviewing the patch and correcting my
careless mistakes! I'll check if my mind is in a clear thinking state
next time.


>
>thanks,
>
>Mimi
>
>> +		digsig = -1;
>>  	}
>>  	if (result == 1 || evm_revalidate_status(xattr_name)) {
>>  		ima_reset_appraise_flags(d_backing_inode(dentry), digsig);
>

-- 
Best regards,
Coiby

