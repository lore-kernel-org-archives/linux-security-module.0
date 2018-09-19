From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Wed, 19 Sep 2018 17:00:02 +0300
Subject: [PATCH v3 03/20] tpm: factor out tpm 1.x duration calculation to
	tpm1-cmd.c
In-Reply-To: <20180919135517.GC26571@linux.intel.com>
References: <20180918093459.19165-1-tomas.winkler@intel.com>
	<20180918093459.19165-4-tomas.winkler@intel.com>
	<20180919135517.GC26571@linux.intel.com>
Message-ID: <20180919140002.GF26571@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, Sep 19, 2018 at 04:55:17PM +0300, Jarkko Sakkinen wrote:
> On Tue, Sep 18, 2018 at 12:34:42PM +0300, Tomas Winkler wrote:
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (C) 2004 IBM Corporation
> > + * Copyright (C) 2014 Intel Corporation
> > + *
> > + * Authors:
> > + * Leendert van Doorn <leendert@watson.ibm.com>
> > + * Dave Safford <safford@watson.ibm.com>
> > + * Reiner Sailer <sailer@watson.ibm.com>
> > + * Kylene Hall <kjhall@us.ibm.com>
> 
> > + *
> > + * Device driver for TCG/TCPA TPM (trusted platform module).
> > + * Specifications at www.trustedcomputinggroup.org
> > + *
> 
> This paragraph is not needed. No need to carry it to a new file.
> 
> > + * This program is free software; you can redistribute it and/or
> > + * modify it under the terms of the GNU General Public License as
> > + * published by the Free Software Foundation, version 2 of the
> > + * License.
> > + *
> > + */
> 
> Cut this out as SPDX takes already care of this.
> 
> /Jarkko

Forgot to add this:

Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
