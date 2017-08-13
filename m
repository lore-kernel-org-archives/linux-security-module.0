From: serge@hallyn.com (Serge E. Hallyn)
Date: Sun, 13 Aug 2017 11:24:34 -0500
Subject: [PATCH 2/4] selinux: Adjust jump targets in ebitmap_read()
In-Reply-To: <2c4582c9-efc1-4b8c-1095-84e00062c7de@users.sourceforge.net>
References: <e9f47cc9-fda7-dc54-bca9-cae6488914e0@users.sourceforge.net>
	<2c4582c9-efc1-4b8c-1095-84e00062c7de@users.sourceforge.net>
Message-ID: <20170813162434.GD4515@mail.hallyn.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Quoting SF Markus Elfring (elfring at users.sourceforge.net):
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 13 Aug 2017 15:21:43 +0200
> 
> Adjust jump targets so that the function implementation becomes smaller.

By how much?
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
