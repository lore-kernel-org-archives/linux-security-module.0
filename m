From: mjg59@google.com (Matthew Garrett)
Date: Tue, 7 Nov 2017 06:49:20 -0800
Subject: [PATCH v2 00/15] ima: digest list feature
In-Reply-To: <20171107103710.10883-1-roberto.sassu@huawei.com>
References: <20171107103710.10883-1-roberto.sassu@huawei.com>
Message-ID: <CACdnJutBFhCpudkbE0uKx1Ja=p8NUrmTMnA+9F4Y7+a7ioE8jA@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, Nov 7, 2017 at 2:36 AM, Roberto Sassu <roberto.sassu@huawei.com> wrote:
> Finally, digest lists address also the third issue because Linux
> distribution vendors already provide the digests of files included in each
> RPM package. The digest list is stored in the RPM header, signed by the
> vendor.

RPM's hardly universal, and distributions are in the process of moving
away from using it for distributing non-core applications (Flatpak and
Snap are becoming increasingly popular here). I think this needs to be
a generic solution rather than having the kernel tied to a specific
package format.
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
