From: mjg59@google.com (Matthew Garrett)
Date: Wed, 25 Oct 2017 07:17:17 -0700
Subject: Fixing CVE-2017-15361
In-Reply-To: <20171025134438.vgh6tzkups2tujps@linux.intel.com>
References: <20171025134438.vgh6tzkups2tujps@linux.intel.com>
Message-ID: <CACdnJus6=3XJEVsQEVY-sxqcUm2At4fKi5Ya+w0Hf==yq7ubKQ@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, Oct 25, 2017 at 6:44 AM, Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
> I'm implementing a fix for CVE-2017-15361 that simply blacklists
> vulnerable FW versions. I think this is the only responsible action from
> my side that I can do.

I'm not sure this is ideal - do Infineon have any Linux tooling for
performing firmware updates, and if so will that continue working if
the device is blacklisted? It's also a poor user experience to have
systems using TPM-backed disk encryption keys suddenly rendered
unbootable, and making it as easy as possible for people to do an
upgrade and then re-seal secrets with new keys feels like the correct
approach.
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
