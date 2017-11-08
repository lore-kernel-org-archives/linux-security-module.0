From: jgg@ziepe.ca (Jason Gunthorpe)
Date: Wed, 8 Nov 2017 15:24:34 -0700
Subject: [PATCH] tpm: Update MAINTAINERS for Jason Gunthorpe
In-Reply-To: <E803B459-CB11-4E23-B3BC-4DEF2A0C40B6@gmx.de>
References: <20171031202357.GA1030@ziepe.ca>
	<20171103142841.2nphkjojzamrdezm@linux.intel.com>
	<0812DDC3-187D-4F29-BFB5-9A4F509CA376@gmx.de>
	<20171107150356.uln3lks64zt5oxjv@linux.intel.com>
	<20171108063640.kxwag6fzguetpjnf@linux.intel.com>
	<E803B459-CB11-4E23-B3BC-4DEF2A0C40B6@gmx.de>
Message-ID: <20171108222434.GF7063@ziepe.ca>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, Nov 08, 2017 at 10:27:37AM +0100, Peter Huewe wrote:

> >Updating that file goes out of my territory other than acking the
> >updates. 

> Imho not really, since there is no MAINTAINERS maintainer.  If you
> feel uncomfortable with adding the changes to MAINTAINERS via your
> tree, please ask James to pull them up - just as Mimi did for her
> linux-integrity update.

Agreed, if you are submitting pull requests then the MAINTAINERS
update for TPM related things should go into your pull request. That
is appropriate..

It isn't necessary for everything to be cc'd everywhere, ultimately it
is your responsibility as the TPM maintainer to accept/reject this
change.

If it was a larger change, like adding/removing a maintainer then a
large audiance would be appropriate, but this is just changing
spelling and the patch was PGP signed ..

Jason
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
