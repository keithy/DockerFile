#!/bin/sh

# make a fake bash  /bin/bash if missing
if [ ! -f /bin/bash ]; then
  echo "#!/bin/sh" > /usr/bin/bash
  echo "exec sh \"\$@\"" >> /usr/bin/bash 
  chmod a+x /usr/bin/bash
fi

