From: Alexander.Levin@microsoft.com (Sasha Levin)
Date: Tue, 10 Apr 2018 13:50:49 +0000
Subject: [PATCH] uapi/linux/keyctl.h: don't use C++ reserved keyword as a
	struct member name
In-Reply-To: <1735b3a4-2792-0ce4-3bf4-94fee5b50ff6@infradead.org>
References: <1735b3a4-2792-0ce4-3bf4-94fee5b50ff6@infradead.org>
Message-ID: <DM5PR2101MB1032FCB3C25A4F8B7F778073FBBE0@DM5PR2101MB1032.namprd21.prod.outlook.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi,

[This is an automated email]

This commit has been processed because it contains a "Fixes:" tag,
fixing commit: .

The bot has also determined it's probably a bug fixing patch. (score: 15.7018)

The bot has tested the following trees: v4.16.1, v4.15.16, v4.14.33, v4.9.93, v4.4.127.

v4.16.1: Build OK!
v4.15.16: Build OK!
v4.14.33: Build OK!
v4.9.93: Failed to apply! Possible dependencies:
    7cbe0932c2f2 ("KEYS: Convert KEYCTL_DH_COMPUTE to use the crypto KPP API")

v4.4.127: Failed to apply! Possible dependencies:
    7cbe0932c2f2 ("KEYS: Convert KEYCTL_DH_COMPUTE to use the crypto KPP API")
    ddbb41148724 ("KEYS: Add KEYCTL_DH_COMPUTE command")


--
Thanks,
Sasha--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
