Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793264546;
	b=bFGGcuFm24eixbyjn1L4odUmFTS1nZc7ZKZLmd8cby7qBSKVih4Ye0HDTXPw4mwQ3Bjy
	 FuGbLHshxRXNfY9jYpr8pWEtNMgrXxHzaUWYtga3qsUoqQW8sq99h68IozFirqNjyECL8
	 Q70bw2TwySjGPxpqrwgjDZj+FjRU8imp1T7as90INLMKIQlwThWrZIpruNsUcrPy3/f7A
	 SIcDd/nmUJhRmSwf5CXfd2QmFh4d+q7uQ/N8z8amfopQBx7nVKVPTxVx849R3++hxRBQH
	 zNOSBTkiGiJ+Gzver3LfVuaYuffdeMOPA1N9n6n/5MWG1rM5wXPce1dXxLtgcIbegwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793264546;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Em6bj94swsrfUrSQCXEn0xceZl+9/C90nnaFaaRvExo=;
	b=hQsyuFR88hMtDu4YQDhRf9HTBAYMaXEHbCVih2AbgLf+eMfdBYgSlm0BfxFi80gQ18Ec
	 oB+rIPqzGJjeOTIwDmPzOSwtl04asfkI8SoFQqoqufwhlkmARN+dqTJV9iueXnVD0fUjL
	 r/dVSnkqhNyPCeBaFu3ov/isy5XZmheW89G44cFE6zEB4e9o6e4oSF1Vj4nPDtxAsqlhg
	 qWukucPSvo/JUDxgflEQcJC1PgRBkfq6iLvZsn1oGjCd7+84T80ZwYMy1TOK47jFh9x7d
	 ICD6X2spcIeh0JImg6V+Pj+nIqKTDRh9bpHrIQ8sJ8edG86p2olVudQuGLByLn0JCxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=v+GdMNW6;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C88160A2624
	for <linux-security-module@vger.kernel.org>; Thu, 29 Oct 2026 09:02:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0C88160A2624
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=v+GdMNW6
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-36661f953e4so3072783eec.1
        for <linux-security-module@vger.kernel.org>; Thu, 29 Oct 2026 02:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793264545; x=1793869345; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Em6bj94swsrfUrSQCXEn0xceZl+9/C90nnaFaaRvExo=;
        b=v+GdMNW6VY8ycTHLfDP4t6NciTC2osSPI32ktEngjDdXmrE1hV/8sVFvczzMG693wH
         roVa6n53id4X2dMpgKp+DjKqlllj47SDkvmmr5ezZIF6LlLu+SfhNQ39/aI40vZyy/Ou
         Z1x9lLclc65fddRgXyNElq4cBZ3FdzDnQWpxJBWLnGus4aXlTpZrVX2FyKbfkpUX7GqO
         UaDKWWAG9kKEfxQX1GODfbN966lJz+jj0swpTaqnlP09hOWI4hrbKWS7mXwGGaGBXmXw
         gl0z03dnYTdfH6Ezjkip09l+kSpsRBWcpFY8YDksWET3NGpvEJTPB4mI02mkjQWTgD9d
         xICA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793264545; x=1793869345;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Em6bj94swsrfUrSQCXEn0xceZl+9/C90nnaFaaRvExo=;
        b=ZQNkVpCxc3k1dLU0jg9BCj/fwqVdM6zYEKFPe9suStCbjQFiGzolWwGCDX/fvYzFoX
         sOsoGxg2ySTnrVFJaMppVJfyuTKQzA2r7cPT3Dq5SUAx2r/l8Q4H79/5qFOAsR5ftAjT
         vTtP7zsZXOUdW1aW8qMmTxpdpiCvys/DvsaZf8mdv1Q7a8MyuP7G3fnUPrRQ/J/WRjmt
         oE3ao9/iYDuto6ssq73pwjIMLRI3tSMrbvljcBi/II0i/j/Z1Vnzclg3BBOwGV+tF0t+
         PmO1HVEJqB+9XAuEg9o/taOXAROxGTANFc2PloZXPCak+pZtG+4DrfbSCsDeIloxHi46
         346A==
X-Forwarded-Encrypted: i=1; AKwUvBwxU69zqGjnKaZocPUVM/v1u2nk+n/104S8LkdOmIlbCNU1LkknhefrBF3epnoshGO7YbTmIvWEJLfjL9qDsoVWofEjb1A=@vger.kernel.org
X-Gm-Message-State: AFq9FYKt01KX8qJ2TDKnnHGndamTmfxmwBVS09nEQDCoxhQUxmBzXGUH
	zrypAmCLpAV83apOI6TyFjwjOf5heLAPRLNNxUeD+c7iWe9OjSXZW7U=
X-Gm-Gg: AYBFou3oNiVsWoMk+ksBmOnFCE/IOpNZt0nXs8mgt3fVGa3W8Puuhzy/Js+z+Blwx1o
	SKHfYgiRluBJFwh0fMAYvd9NrfrYnGTj4pgru38AYNg4bmHoI26EoYnLH308JkTQ7VO7Ydx8GYr
	CrXz7+cRObF2iJ1TpsN32h5Ic7iOuezzO9vMo/C6hVnosTmFi0n0wNVpmNGO3b/OEYxa3tCIOXS
	OhzYZx5AVDur0fX9SYxEdrcDbo79ixw0Sa8Scr7AMRdsmzpQ/sCVfxOKe9ncAeQA7hWqWEA49De
	p3BC6N7WMGLo9jHN1En6CpXCFBdK61HhQLynnSGcOVcWg+wYT4FcoR+iajjlYcrQco4pAQy4ZaJ
	3WtiVgX+TPerGITSc8gpBeIU0Ksb6qBTJ087FfMsgorvsT1XmHRW0vJcvokJLmBK/ICmZqqlYfN
	E5AljiI4QmrmrpdRhaNUyCKtRDq+JqKc4kep9/KCvWzKIpm7MDMDG8Geo47zl4/TGXsWsS4epIn
	Jm3PK5IT41OboXD2P5D0N4pJbrfThoFuORzMV/UpmX9IhEz3Jfzc+gOjkS7X7teJG8IUTngDs6f
	qEEkoIPUES/ZzDDxP8KoI1a0WkT2Jo1kB0L79v3Nss/PsW9U/1HLBuNBJXANFKc8+GV0XWZvxvO
	GUfBk67w=
X-Received: by 2002:a05:7300:7312:b0:358:ec5c:bef1 with SMTP id 5a478bee46e88-36a204773c0mr9949917eec.39.1793264544951;
        Thu, 29 Oct 2026 02:02:24 -0700 (PDT)
Received: from at-Standard-PC-Q35-ICH9-2009 ([27.60.20.232])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a23641e78sm16497937eec.0.2026.10.29.02.02.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 02:02:24 -0700 (PDT)
From: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
To: 
Cc: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Sven Peter <sven@kernel.org>,
	Janne Grunau <j@jannau.net>,
	Neal Gompa <neal@gompa.dev>,
	Guenter Roeck <linux@roeck-us.net>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Griffin Kroah-Hartman <griffin@kroah.com>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sebastian Reichel <sre@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-hwmon@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-leds@vger.kernel.org,
	mfd@lists.linux.dev,
	platform-driver-x86@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-rtc@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [RFC PATCH 14/14] mfd/macsmc: add ioctl to access smc keys
Date: Thu, 29 Oct 2026 04:52:11 -0400
Message-ID: <20261029085504.3547-15-atharvatiwarilinuxdev@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261029085504.3547-1-atharvatiwarilinuxdev@gmail.com>
References: <20261029085504.3547-1-atharvatiwarilinuxdev@gmail.com>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a /dev/smc device so userspace can talk to the SMC
directly. Some keys that need to be written aren't handled by
any driver, or affect several drivers at once, so they
can't be exposed cleanly through the kernel interfaces.

Keys already managed by kernel drivers can't be written this
way, to avoid conflicts.

Signed-off-by: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
---
 drivers/mfd/macsmc-core.c  | 155 +++++++++++++++++++++++++++++++++++++
 include/linux/mfd/macsmc.h |  27 +++++++
 2 files changed, 182 insertions(+)

diff --git a/drivers/mfd/macsmc-core.c b/drivers/mfd/macsmc-core.c
index bc4200f57..a30f7386e 100644
--- a/drivers/mfd/macsmc-core.c
+++ b/drivers/mfd/macsmc-core.c
@@ -6,10 +6,13 @@
 
 #include <linux/bitfield.h>
 #include <linux/device.h>
+#include <linux/fs.h>
 #include <linux/mfd/core.h>
 #include <linux/mfd/macsmc.h>
+#include <linux/miscdevice.h>
 #include <linux/mutex.h>
 #include <linux/spinlock.h>
+#include <linux/uaccess.h>
 
 static const struct mfd_cell apple_smc_rtkit_devs[] = {
 	MFD_CELL_NAME("macsmc-input"),
@@ -112,6 +115,144 @@ static void apple_smc_disable_notifications(void *data)
 	smc->be->disable_notifications(smc->be_cookie);
 }
 
+static long apple_smc_fops_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+{
+	struct apple_smc *smc = file->private_data;
+	void __user *argp = (void __user *)arg;
+	int ret;
+
+	switch (cmd) {
+	case IOCTL_SMC_READ: {
+		struct ioctl_smc_rw_payload payload;
+		struct apple_smc_key_info info;
+
+		if (copy_from_user(&payload, argp, sizeof(payload)))
+			return -EFAULT;
+
+		ret = apple_smc_get_key_info(smc, payload.key, &info);
+		if (ret < 0)
+			return ret;
+
+		if (payload.size != info.size)
+			return -EINVAL;
+
+		if (payload.size > 32)
+			return -EINVAL;
+
+		ret = apple_smc_read(smc, payload.key, payload.buf, payload.size);
+		if (ret < 0)
+			return ret;
+
+		if (copy_to_user(argp, &payload, sizeof(payload)))
+			return -EFAULT;
+		return 0;
+	}
+	case IOCTL_SMC_WRITE: {
+		struct ioctl_smc_rw_payload payload;
+		struct apple_smc_key_info info;
+
+		if (copy_from_user(&payload, argp, sizeof(payload)))
+			return -EFAULT;
+
+		ret = apple_smc_get_key_info(smc, payload.key, &info);
+		if (ret < 0)
+			return ret;
+
+		if (payload.size != info.size)
+			return -EINVAL;
+
+		if (payload.size > 32)
+			return -EINVAL;
+
+		switch (payload.key) {
+		case __SMC_KEY('C', 'H', '0', 'I'):
+		case __SMC_KEY('C', 'H', '0', 'C'):
+		case __SMC_KEY('C', 'H', '0', 'K'):
+		case __SMC_KEY('C', 'H', '0', 'B'):
+		case __SMC_KEY('C', 'H', 'T', 'E'):
+		case __SMC_KEY('C', 'H', 'L', 'S'):
+		case __SMC_KEY('B', 'C', 'L', 'M'):
+		case __SMC_KEY('M', 'B', 'S', 'E'):
+		case __SMC_KEY('C', 'L', 'K', 'L'):
+		case __SMC_KEY('C', 'L', 'K', 'O'):
+		case __SMC_KEY('O', 'S', 'W', 'D'):
+		case __SMC_KEY('N', 'A', 'T', 'J'):
+		case __SMC_KEY('N', 'A', 'T', 'i'):
+		case __SMC_KEY('N', 'E', 'S', 'N'):
+		case __SMC_KEY('M', 'O', 'C', 'N'):
+		case __SMC_KEY('L', 'K', 'S', 'B'):
+		case __SMC_KEY('N', 'T', 'O', 'K'):
+		case __SMC_KEY('N', 'T', 'A', 'P'):
+		case __SMC_KEY('F', '0', 'T', 'g'):
+		case __SMC_KEY('F', '1', 'T', 'g'):
+		case __SMC_KEY('F', '0', 'M', 'd'):
+		case __SMC_KEY('F', '1', 'M', 'd'):
+		case __SMC_KEY('F', 'S', '!', ' '):
+			return -EPERM;
+		}
+
+		ret = apple_smc_write(smc, payload.key, payload.buf, payload.size);
+		if (ret < 0)
+			return ret;
+
+		return 0;
+	}
+	case IOCTL_SMC_GET_KEY_INDEX: {
+		struct ioctl_smc_index_payload payload;
+
+		if (copy_from_user(&payload, argp, sizeof(payload)))
+			return -EFAULT;
+
+		ret = apple_smc_get_key_by_index(smc, payload.index, &payload.key);
+		if (ret < 0)
+			return ret;
+
+		if (copy_to_user(argp, &payload, sizeof(payload)))
+			return -EFAULT;
+
+		return 0;
+	}
+	case IOCTL_SMC_GET_KEY_INFO: {
+		struct ioctl_smc_info_payload payload;
+
+		if (copy_from_user(&payload, argp, sizeof(payload)))
+			return -EFAULT;
+
+		ret = apple_smc_get_key_info(smc, payload.key, &payload.info);
+		if (ret < 0)
+			return ret;
+
+		if (copy_to_user(argp, &payload, sizeof(payload)))
+			return -EFAULT;
+
+		return 0;
+	}
+	default:
+		return -EINVAL;
+	}
+}
+
+static int apple_smc_fops_open(struct inode *inode, struct file *file)
+{
+	struct miscdevice *misc = file->private_data;
+
+	file->private_data = container_of(misc, struct apple_smc, miscdev);
+	return 0;
+}
+
+static const struct file_operations apple_smc_fops = {
+	.owner		= THIS_MODULE,
+	.open		= apple_smc_fops_open,
+	.unlocked_ioctl	= apple_smc_fops_ioctl,
+	.compat_ioctl	= compat_ptr_ioctl,
+	.llseek		= noop_llseek,
+};
+
+static void apple_smc_misc_unregister(void *data)
+{
+	misc_deregister(data);
+}
+
 int apple_smc_probe(struct device *dev, const struct apple_smc_backend_ops *ops,
 		void *cookie, struct blocking_notifier_head *event_handlers, bool is_acpi)
 {
@@ -150,6 +291,20 @@ int apple_smc_probe(struct device *dev, const struct apple_smc_backend_ops *ops,
 	if (ret)
 		return ret;
 
+	smc->miscdev.minor = MISC_DYNAMIC_MINOR;
+	smc->miscdev.name = "smc";
+	smc->miscdev.fops = &apple_smc_fops;
+	smc->miscdev.parent = dev;
+	smc->miscdev.mode = 0600;
+
+	ret = misc_register(&smc->miscdev);
+	if (ret)
+		return ret;
+
+	ret = devm_add_action_or_reset(dev, apple_smc_misc_unregister, &smc->miscdev);
+	if (ret)
+		return ret;
+
 	if (smc->is_acpi) {
 		ret = devm_mfd_add_devices(dev, -1, apple_smc_acpi_common,
 			ARRAY_SIZE(apple_smc_acpi_common), NULL, 0, NULL);
diff --git a/include/linux/mfd/macsmc.h b/include/linux/mfd/macsmc.h
index 4b4368b99..29fd7b20c 100644
--- a/include/linux/mfd/macsmc.h
+++ b/include/linux/mfd/macsmc.h
@@ -8,6 +8,8 @@
 #ifndef _LINUX_MFD_MACSMC_H
 #define _LINUX_MFD_MACSMC_H
 
+#include <linux/ioctl.h>
+#include <linux/miscdevice.h>
 #include <linux/soc/apple/rtkit.h>
 
 /**
@@ -125,6 +127,7 @@ struct apple_smc_backend_ops {
  * @is_acpi: Is the backend ACPI based
  * @mutex: Mutex for non-atomic mode
  * @lock: Spinlock for atomic mode
+ * @miscdev: Misc Device struct for ioctl ops
  */
 struct apple_smc {
 	struct device *dev;
@@ -141,8 +144,32 @@ struct apple_smc {
 
 	struct mutex mutex;
 	spinlock_t lock;
+
+	struct miscdevice miscdev;
+};
+
+struct ioctl_smc_rw_payload {
+	smc_key key;
+	size_t size;
+	u8 buf[32];
+};
+
+struct ioctl_smc_index_payload {
+	int index;
+	smc_key key;
+};
+
+struct ioctl_smc_info_payload {
+	smc_key key;
+	struct apple_smc_key_info info;
 };
 
+#define APPLE_SMC_MAGIC 'S'
+#define IOCTL_SMC_READ           _IOWR(APPLE_SMC_MAGIC, 1, struct ioctl_smc_rw_payload)
+#define IOCTL_SMC_WRITE          _IOW(APPLE_SMC_MAGIC, 2, struct ioctl_smc_rw_payload)
+#define IOCTL_SMC_GET_KEY_INDEX  _IOWR(APPLE_SMC_MAGIC, 3, struct ioctl_smc_index_payload)
+#define IOCTL_SMC_GET_KEY_INFO   _IOWR(APPLE_SMC_MAGIC, 4, struct ioctl_smc_info_payload)
+
 /**
  * apple_smc_read - Read size bytes from given SMC key into buf
  * @smc: Pointer to apple_smc struct
-- 
2.55.0

